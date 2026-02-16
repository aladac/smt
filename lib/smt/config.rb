# frozen_string_literal: true

require 'yaml'

module Smt
  class Config
    CONFIG_PATH = File.join(Dir.home, '.smtrc.yml').freeze

    def self.load
      return unless File.exist?(CONFIG_PATH)

      YAML.safe_load_file(CONFIG_PATH, permitted_classes: [Symbol], symbolize_names: true)
    end
  end
end
