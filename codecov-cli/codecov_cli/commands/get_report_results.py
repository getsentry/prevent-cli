import logging

import click
import sentry_sdk

from codecov_cli.helpers.args import get_cli_args
from codecov_cli.helpers.encoder import encode_slug
from codecov_cli.helpers.options import global_options
from codecov_cli.services.report import send_reports_result_get_request
from codecov_cli.types import CommandContext


logger = logging.getLogger("codecovcli")


@click.command(hidden=True, deprecated=True)
@click.option(
    "--code", help="The code of the report. If unsure, leave default", default="default"
)
@global_options
@click.pass_context
def get_report_results(
    ctx: CommandContext,
    commit_sha: str,
    code: str,
    slug: str,
    git_service: str,
    token: str,
    fail_on_error: bool,
):
    with sentry_sdk.start_transaction(op="task", name="Get Report Results"):
        with sentry_sdk.start_span(name="get_report_results"):
            enterprise_url = ctx.obj.get("enterprise_url")
            args = get_cli_args(ctx)
            logger.debug(
                "Getting report results",
                extra=dict(
                    extra_log_attributes=args,
                ),
            )
            encoded_slug = encode_slug(slug)
            send_reports_result_get_request(
                commit_sha=commit_sha,
                report_code=code,
                encoded_slug=encoded_slug,
                service=git_service,
                token=token,
                enterprise_url=enterprise_url,
                fail_on_error=fail_on_error,
            )
