require 'slate/formatters'
require 'slate/future_factory'
require 'slate/log_entry_decorator'
require 'slate/logger'
require 'slate/metrics'
require 'slate/version'

require 'slate/controller/request_id_manager'
require 'slate/controller/correlation_id_manager'
require 'slate/controller/action_timer'

if defined?(Rails)
  require 'slate/railtie'
end

module Slate
end
