# Copied from https://github.com/python-poetry/poetry/issues/273#issuecomment-1103812336
from importlib import metadata

__version__ = metadata.version("freshli-agent-python")

# avoids polluting the results of dir(__package__)
del metadata
