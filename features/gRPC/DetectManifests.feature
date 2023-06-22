Feature: Invoking DetectManifests via gRPC
  The `DetectManifests` gRPC call is used to detect the manifest files in a directory tree that will be used to generate
  CycloneDX-based bill of materials (bom) files. For Python projects, this is relatively simple. One of the supported
  manifest file formats just needs to be returned. Current support includes `requirements.txt` via `pip`, `Pipfile` via
  `pipenv`, and `poetry.lock` via `poetry`.

  The call is provided with the full path to a directory that should be scanned for manifest files.

  For each manifest file that is listed, the response needs to contain the full path to the file.

  @announce-output
  Scenario: A project that includes a `requirements.txt` file
  This project contains a single `requirements.txt` file in the root directory of the repository.

    Given I clone the git repository "https://github.com/rafalp/Misago" with the sha "0d326040a77cf1a3bff71b8082a48573c6340285"
    When I run `freshli-agent-python start-server 9192` interactively
    Then I wait for the freshli_agent.proto gRPC service to be running on port 9192
    And I call DetectManifests with the full path to "tmp/repositories/Misago" on port 9192
    Then the DetectManifests response contains the following file paths expanded beneath "tmp/repositories/Misago":
    """
    requirements.txt
    """
    When the gRPC service on port 9192 is sent the shutdown command
    Then there are no services running on port 9192
    And the exit status should be 0

  Scenario: A project that contains multiple `requirements.txt` files
  This project contains multiple `requirements.txt` files in deeply-nested subdirectories. Each file should be listed.

    Given I clone the git repository "https://github.com/istio/istio" with the sha "8652668835700c4e278dac4437a9e736602bc559"
    When I run `freshli-agent-python start-server 9192` interactively
    Then I wait for the freshli_agent.proto gRPC service to be running on port 9192
    And I call DetectManifests with the full path to "tmp/repositories/istio" on port 9192
    Then the DetectManifests response contains the following file paths expanded beneath "tmp/repositories/istio":
    """
    samples/bookinfo/src/productpage/requirements.txt
    samples/helloworld/src/requirements.txt
    security/tools/jwt/requirements.txt
    security/tools/jwt/samples/requirements.txt
    """
    When the gRPC service on port 9192 is sent the shutdown command
    Then there are no services running on port 9192
    And the exit status should be 0

  Scenario: A project that contains a `poetry.lock` file
  This project contains a single `poetry.lock` file in the root directory of the repository.

    Given I clone the git repository "https://github.com/jrnl-org/jrnl" with the sha "9edc7c5cc0e97afd92d6b4b278845f7ff1a57418"
    When I run `freshli-agent-python start-server 9192` interactively
    Then I wait for the freshli_agent.proto gRPC service to be running on port 9192
    And I call DetectManifests with the full path to "tmp/repositories/jrnl" on port 9192
    Then the DetectManifests response contains the following file paths expanded beneath "tmp/repositories/jrnl":
    """
    poetry.lock
    """
    When the gRPC service on port 9192 is sent the shutdown command
    Then there are no services running on port 9192
    And the exit status should be 0

  Scenario: A project that contains both a `requirements.txt` and `poetry.lock` file
  This project contains both a `requirements.txt` and `poetry.lock` file in the root directory of the repository. Both should be
  listed as a detected manifest.

    Given I clone the git repository "https://github.com/saleor/saleor" with the sha "b7d1b320e096d99567d3fa7bc4780862809d19ac"
    When I run `freshli-agent-python start-server 9192` interactively
    Then I wait for the freshli_agent.proto gRPC service to be running on port 9192
    And I call DetectManifests with the full path to "tmp/repositories/saleor" on port 9192
    Then the DetectManifests response contains the following file paths expanded beneath "tmp/repositories/saleor":
    """
    poetry.lock
    requirements.txt
    """
    When the gRPC service on port 9192 is sent the shutdown command
    Then there are no services running on port 9192
    And the exit status should be 0

  Scenario: A project with a `Pipfile.lock` file
  This project contains a single `Pipfile.lock` file in the root directory of the repository.

    Given I clone the git repository "https://github.com/frostming/legit" with the sha "e23d707ead0ec85b3d81b8d25b8e743bef737b80"
    When I run `freshli-agent-python start-server 9192` interactively
    Then I wait for the freshli_agent.proto gRPC service to be running on port 9192
    And I call DetectManifests with the full path to "tmp/repositories/legit" on port 9192
    Then the DetectManifests response contains the following file paths expanded beneath "tmp/repositories/legit":
    """
    Pipfile.lock
    """
    When the gRPC service on port 9192 is sent the shutdown command
    Then there are no services running on port 9192
    And the exit status should be 0
