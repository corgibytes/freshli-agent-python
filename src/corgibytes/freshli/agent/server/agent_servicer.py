from corgibytes.freshli.agent.detect_manifests_command import DetectManifestsCommand


class AgentServicer(corgibytes.freshli.agent.freshli_agent_pb2_grpc.AgentServicer):
    def DetectManifests(self, request, context):
        command = DetectManifestsCommand(request.project_path)
        result = command.execute()

        return corgibytes.freshli.agent.freshli_agent_pb2.DetectManifestsResponse(manifest_paths=result)

    def ProcessManifest(self, request, context):
        pass

    def RetrieveReleaseHistory(self, request, context):
        pass

    def GetValidatingPackages(self, request, context):
        pass

    def GetValidatingRepositories(self, request, context):
        pass

    def Shutdown(self, request, context):
        pass
