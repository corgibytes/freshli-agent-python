import pytest
from expecter import expect

from corgibytes.freshli.agent.commands.detect_manifests_command import DetectManifestsCommand


def describe_detect_manifests_command():

    def describe_with_pip():
        @pytest.fixture
        def command(shared_datadir):
            return DetectManifestsCommand(shared_datadir / 'pip')

        def it_detects_manifests(command, shared_datadir):
            expect(command.execute()) == resolve_paths([
                shared_datadir / 'pip/requirements.txt',
            ])

    def describe_with_pipenv():
        @pytest.fixture
        def command(shared_datadir):
            return DetectManifestsCommand(shared_datadir / 'pipenv')

        def it_detects_manifests(command, shared_datadir):
            expect(command.execute()) == resolve_paths([
                shared_datadir / 'pipenv/Pipfile.lock',
            ])

    def describe_with_poetry():
        @pytest.fixture
        def command(shared_datadir):
            return DetectManifestsCommand(shared_datadir / 'poetry')

        def it_detects_manifests(command, shared_datadir):
            expect(command.execute()) == resolve_paths([
                shared_datadir / 'poetry/poetry.lock',
            ])

    def describe_with_root():
        @pytest.fixture
        def command(shared_datadir):
            return DetectManifestsCommand(shared_datadir)

        def it_detects_manifests(command, shared_datadir):
            expect(command.execute()) == resolve_paths([
                shared_datadir / 'pip/requirements.txt',
                shared_datadir / 'pipenv/Pipfile.lock',
                shared_datadir / 'poetry/poetry.lock',
            ])

def resolve_paths(paths):
    return [str(p) for p in paths]
