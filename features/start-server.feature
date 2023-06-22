Feature: `start-server` command

  The `start-server` starts a gRPC server as described in `freshli_agent.proto`. After the server
  is started, the process blocks until either the process is terminated or the `Shutdown` RPC
  function is called. Once the gRPC server is ready for connections, then a message is written
  to the console. If the specified port is not available, then the process terminates immediately
  with a non-zero exit code after outputting an error message.

  Scenario: Starting the server with a provided port number
    Given there are no services running on port 9124
    When I run `freshli-agent-python start-server 9124` interactively
    Then I wait for the freshli_agent.proto gRPC service to be running on port 9124
    When the gRPC service on port 9124 is sent the shutdown command
    Then there are no services running on port 9124
    And the exit status should be 0

  Scenario: Starting the service with a provided port number that is already in use
    Given a test service is started on port 9125
    When I run `freshli-agent-python start-server 9125`
    Then the output should contain:
    """
    Unable to start the gRPC service. Port 9125 is in use.
    """
    And the exit status should not be 0
    When the test service running on port 9125 is stopped
    Then there are no services running on port 9125
