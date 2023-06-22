import grpc

from corgibytes.freshli.agent.commands.detect_manifests_command import DetectManifestsCommand
from corgibytes.freshli.agent.grpc import freshli_agent_pb2_grpc
from corgibytes.freshli.agent.grpc import freshli_agent_pb2
from google.protobuf import empty_pb2

import logging


class AgentServicer(freshli_agent_pb2_grpc.AgentServicer):
    def __init__(self, server: grpc.Server):
        self.server = server

    def DetectManifests(self, request, context):
        command = DetectManifestsCommand(request.path)
        result = command.execute()

        def generate():
            for path in result:
                yield freshli_agent_pb2.ManifestLocation(path=path)

        return generate()

    def ProcessManifest(self, request, context):
        pass

    def RetrieveReleaseHistory(self, request, context):
        pass

    def GetValidatingPackages(self, request, context):
        pass

    def GetValidatingRepositories(self, request, context):
        pass

    def Shutdown(self, request, context):
        self.server.stop(0)
        return empty_pb2.Empty()

