require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/all'

OpenTelemetry::SDK.configure do |c|
  c.service_name = ENV['OTEL_SERVICE_NAME']

  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(
        endpoint: ENV['OTEL_EXPORTER_OTLP_ENDPOINT']
      )
    )
  )

  c.resource = OpenTelemetry::SDK::Resources::Resource.create({
    OpenTelemetry::SemanticConventions::Resource::SERVICE_NAMESPACE => 'tracing',
    OpenTelemetry::SemanticConventions::Resource::SERVICE_NAME => ENV['OTEL_SERVICE_NAME'],
    OpenTelemetry::SemanticConventions::Resource::SERVICE_VERSION => '0.0.1',
  })
end
