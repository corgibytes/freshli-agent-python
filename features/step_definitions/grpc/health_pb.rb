# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: health.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("health.proto", :syntax => :proto3) do
    add_message "grpc.health.v1.HealthCheckRequest" do
      optional :service, :string, 1
    end
    add_message "grpc.health.v1.HealthCheckResponse" do
      optional :status, :enum, 1, "grpc.health.v1.HealthCheckResponse.ServingStatus"
    end
    add_enum "grpc.health.v1.HealthCheckResponse.ServingStatus" do
      value :UNKNOWN, 0
      value :SERVING, 1
      value :NOT_SERVING, 2
      value :SERVICE_UNKNOWN, 3
    end
  end
end

module Grpc
  module Health
    module V1
      HealthCheckRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grpc.health.v1.HealthCheckRequest").msgclass
      HealthCheckResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grpc.health.v1.HealthCheckResponse").msgclass
      HealthCheckResponse::ServingStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grpc.health.v1.HealthCheckResponse.ServingStatus").enummodule
    end
  end
end
