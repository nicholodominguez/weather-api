require 'uptrace'
require 'opentelemetry-instrumentation-rails'

Uptrace.configure_opentelemetry(dsn: ENV['UPTRACE_DSN']) do |c|
  c.use 'OpenTelemetry::Instrumentation::Rails'
end