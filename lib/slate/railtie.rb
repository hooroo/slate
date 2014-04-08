require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/formatter/log4jxmlformatter'
require 'log4r/outputter/fileoutputter'
require 'log4r/outputter/consoleoutputters'
require 'slate/splunk_formatter'

module Slate

  class Railtie < Rails::Railtie

    include Log4r

    initializer "slate_railtie.configure_rails_initialization" do

      log4r_config = YAML.load_file(Rails.root.join('config/log4r.yml'))

      log_cfg = YamlConfigurator
      log_cfg['ENV'] = Rails.env
      log_cfg.decode_yaml(log4r_config)

      Slate::Logger.logger = Log4r::Logger['default']
      Slate::Metrics.logger = Log4r::Logger['metrics']

      Slate::Logger.formatter = Slate::SplunkFormatter
      Slate::Metrics.formatter = Slate::SplunkFormatter

      if Rails.env.development?
        Log4r::Logger['default'].add('console_log')
        Log4r::Logger['metrics'].add('console_log')
      end

    end
  end
end


