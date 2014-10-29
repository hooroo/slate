
require "slate/version"
require "slate/logger"
require "slate/metrics"
require "slate/controller/request_id_manager"
require "slate/controller/correlation_id_manager"
require "slate/controller/action_timer"
require "slate/future_factory"
require "slate/railtie" if defined?(Rails)

module Slate

end
