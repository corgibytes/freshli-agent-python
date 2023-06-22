#!/usr/bin/env ruby
# frozen_string_literal: true

require 'English'
require 'optparse'
require 'fileutils'

require_relative './support/execute'

enable_dotnet_command_colors

perform_build = true

parser = OptionParser.new do |options|
  options.banner = <<~BANNER
    Description:
        Test Runner

    Usage:
        test.rb [options]

    Options:
  BANNER

  options.on('-s', '--skip-build', 'Run tests without first calling build') do
    perform_build = false
  end

  options.on('-h', '--help', 'Show help and usage information') do
    puts options
    exit
  end
end

begin
  parser.parse!
rescue OptionParser::InvalidOption => e
  puts e
  puts parser
  exit(-1)
end

# based on https://stackoverflow.com/a/29743469/243215
def download(url, target_path)
  # rubocop:disable Security/Open
  require 'open-uri'
  download = URI.open(url)
  # rubocop:enable Security/Open
  IO.copy_stream(download, target_path)
end

status = execute("ruby #{File.dirname(__FILE__)}/build.rb") if perform_build

if status.nil? || status.success?
  status = execute("poetry check > #{null_output_target}")
  status = execute('poetry install') unless status.success?

  FileUtils.mkdir_p('features/step_definitions/grpc')

  if status.success?
    status = execute(
      'bundle exec grpc_tools_ruby_protoc -I ./protos/corgibytes/freshli/agent/grpc --ruby_out=./features/step_definitions/grpc ' \
      '--grpc_out=./features/step_definitions/grpc ./protos/corgibytes/freshli/agent/grpc/freshli_agent.proto'
    )
  end

  FileUtils.mkdir_p('tmp')

  if status.success?
    download(
      'https://raw.githubusercontent.com/grpc/grpc/e35cf362a49b4de753cbe69f3e836d2e40408ca2' \
      '/src/proto/grpc/health/v1/health.proto',
      File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'health.proto'))
    )
    status = execute(
      'bundle exec grpc_tools_ruby_protoc -I tmp --ruby_out=features/step_definitions/grpc ' \
      '--grpc_out=features/step_definitions/grpc tmp/health.proto'
    )
  end

  status = execute('poetry run pytest --cov=./src tests') if status.success?
  status = execute('bundle exec cucumber --color --backtrace') if status.success?
end

exit(status.exitstatus)
