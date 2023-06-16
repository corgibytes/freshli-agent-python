import typer

app = typer.Typer()

@app.command()
def validating_package_urls():
    """
    Lists package urls that can be used to validate this agent
    """
    pass

@app.command()
def retrieve_release_history():
    """
    Retrieves release history for a specific package
    """
    pass

@app.command()
def validating_repositories():
    """
    Lists repositories that can be used to validate this agent
    """
    pass

@app.command()
def detect_manifests():
    """
    Detects manifests in the specified directory
    """
    pass

@app.command()
def process_manifest():
    """
    Processes manifest files in the specified directory
    """
    pass

@app.command()
def start_server():
    """
    Starts a gRPC server running the Freshli Agent service
    """
    pass

if __name__ == "__main__":
    app()
