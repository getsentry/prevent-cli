import logging
import typing

import click
import sentry_sdk

from codecov_cli.fallbacks import (
    BrandedCodecovOption,
    BrandedOption,
    CodecovOption,
    FallbackFieldEnum,
)
from codecov_cli.helpers.args import get_cli_args
from codecov_cli.helpers.encoder import slug_without_subgroups_is_invalid
from codecov_cli.services.commit.base_picking import base_picking_logic
from codecov_cli.types import CommandContext

logger = logging.getLogger("codecovcli")


@click.command()
@click.option(
    "--base-sha",
    help="Base commit SHA (with 40 chars)",
    cls=CodecovOption,
    fallback_field=FallbackFieldEnum.commit_sha,
    required=True,
)
@click.option(
    "--pr",
    help="Pull Request id to associate commit with",
    cls=CodecovOption,
    fallback_field=FallbackFieldEnum.pull_request_number,
)
@click.option(
    "--slug",
    cls=BrandedCodecovOption,
    fallback_field=FallbackFieldEnum.slug,
    help="owner/repo slug",
    envvar="SLUG",
)
@click.option(
    "-t",
    "--token",
    cls=BrandedOption,
    help="Codecov upload token",
    envvar="TOKEN",
)
@click.option(
    "--service",
    cls=CodecovOption,
    fallback_field=FallbackFieldEnum.service,
    help="Specify the service provider of the repo e.g. github",
)
@click.pass_context
def pr_base_picking(
    ctx: CommandContext,
    base_sha: str,
    pr: typing.Optional[int],
    slug: typing.Optional[str],
    token: typing.Optional[str],
    service: typing.Optional[str],
):
    with sentry_sdk.start_transaction(op="task", name="Base Picking"):
        with sentry_sdk.start_span(name="base_picking"):
            enterprise_url = ctx.obj.get("enterprise_url")
            args = get_cli_args(ctx)
            logger.debug(
                "Starting base picking process",
                extra=dict(
                    extra_log_attributes=args,
                ),
            )

            if slug_without_subgroups_is_invalid(slug):
                logger.error(
                    "Slug is invalid. Slug should be in the form of owner_username/repo_name"
                )
                return

            base_picking_logic(base_sha, pr, slug, token, service, enterprise_url, args)
