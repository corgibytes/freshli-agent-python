#!/usr/bin/env ruby
# frozen_string_literal: true

require 'English'
require 'fileutils'

require_relative './support/execute'

enable_dotnet_command_colors

status = execute('poetry run python -m grpc_tools.protoc -I./protos --python_out=./src --pyi_out=./src --grpc_python_out=./src ./protos/corgibytes/freshli/agent/grpc/freshli_agent.proto')

status = execute('poetry run pyinstaller --noconfirm --onedir --name freshli-agent-python --collect-submodules corgibytes --paths src src/corgibytes/freshli/agent/__init__.py') if status.success?

if status
  FileUtils.mkdir_p('exe')
  FileUtils.cp_r('dist/freshli-agent-python/.', 'exe')
end

exit(status.exitstatus)
