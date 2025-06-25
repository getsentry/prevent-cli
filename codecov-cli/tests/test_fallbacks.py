import click

from codecov_cli.fallbacks import BrandedOption
from codecov_cli.branding import Branding

from click.testing import CliRunner


@click.group()
@click.pass_context
def cli(ctx):
    ctx.obj = {}
    ctx.obj["branding"] = [Branding.CODECOV, Branding.PREVENT]


@cli.command()
@click.option("--test", cls=BrandedOption, envvar="TEST")
@click.pass_context
def hello_world(ctx, test):
    click.echo(f"{test}")


def test_branded_option():
    runner = CliRunner()

    result = runner.invoke(cli, ["hello-world"], env={"CODECOV_TEST": "hello_codecov"})
    assert result.output == "hello_codecov\n"

    result = runner.invoke(cli, ["hello-world"], env={"PREVENT_TEST": "hello_prevent"})
    assert result.output == "hello_prevent\n"

    result = runner.invoke(cli, ["hello-world"])
    assert result.output == "None\n"
