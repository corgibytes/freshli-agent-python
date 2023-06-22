import sys

from concurrent import futures

import grpc
from grpc_reflection.v1alpha import reflection
from grpc_health.v1 import health
from grpc_health.v1 import health_pb2
from grpc_health.v1 import health_pb2_grpc

from corgibytes.freshli.agent.commands.command import Command
from corgibytes.freshli.agent.grpc import freshli_agent_pb2
from corgibytes.freshli.agent.grpc import freshli_agent_pb2_grpc
from corgibytes.freshli.agent.server.agent_servicer import AgentServicer

class StartServerCommand(Command):
    def __init__(self, port):
        self.port = port

    def execute(self):
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=10), options=(('grpc.so_reuseport', 0),))

        agent_servicer = AgentServicer(server)
        freshli_agent_pb2_grpc.add_AgentServicer_to_server(agent_servicer, server)

        health_servicer = health.HealthServicer(
            experimental_non_blocking=True,
            experimental_thread_pool=futures.ThreadPoolExecutor(max_workers=10),
        )
        health_pb2_grpc.add_HealthServicer_to_server(health_servicer, server)

        SERVICE_NAMES = (
            freshli_agent_pb2.DESCRIPTOR.services_by_name["Agent"].full_name,
            health.SERVICE_NAME,
            reflection.SERVICE_NAME,
        )
        reflection.enable_server_reflection(SERVICE_NAMES, server)

        try:
            bound_port = server.add_insecure_port('0.0.0.0:' + str(self.port))
        except RuntimeError:
            bound_port = 0

        if bound_port > 0:
            server.start()
            health_servicer.set(
                freshli_agent_pb2.DESCRIPTOR.services_by_name["Agent"].full_name,
                health_pb2.HealthCheckResponse.SERVING
            )
            print("Listening on " + str(self.port) + "...")
            sys.stdout.flush()
            server.wait_for_termination()
            return True
        else:
            print("Unable to start the gRPC service. Port " + str(self.port) + " is in use.")
            return False
