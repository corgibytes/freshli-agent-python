from typing import Annotated, Optional

import typer

from corgibytes.freshli.agent.commands.detect_manifests_command import DetectManifestsCommand
from corgibytes.freshli.agent.commands.start_server_command import StartServerCommand
from corgibytes import __version__

app = typer.Typer(add_completion=False)


def version_callback(value: bool):
    if value:
        print(__version__)
        raise typer.Exit()


@app.callback(no_args_is_help=True)
def main(
    version: Annotated[
        Optional[bool], typer.Option("--version", help="Print the version and exit.", callback=version_callback, is_eager=True)
    ] = None
):
    """
    Freshli Language Agent for Python
    """
    pass


@app.command()
def start_server(port: int):
    """
    Starts a gRPC server running the Freshli Agent service
    """

    command = StartServerCommand(port)
    result = command.execute()
    if not result:
        raise typer.Exit(code=-1)




if __name__ == "__main__":
    app()
