# [Freshli CLI](https://github.com/corgibytes/freshli-cli) Python Agent

`freshli-agent-python' is the Python language agent that is used by the [Freshli CLI](https://github.com/corgibytes/freshli-cli) to analyze Python projects.

## Building and Installing

```bash
poetry install

# generate gRPC files
poetry run python -m grpc_tools.protoc -I./protos --python_out=./src/corgibytes/freshli/agent/grpc --pyi_out=./src/corgibytes/freshli/agent/grpc --grpc_python_out=./src/corgibytes/freshli/agent/grpc ./protos/freshli_agent.proto

poetry build
pip install ./dist/freshli_agent_python*.whl
```

## License

This project is licensed under the [GNU Affero General Public License](./LICENSE).
