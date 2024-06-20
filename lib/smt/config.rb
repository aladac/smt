# frozen_string_literal: true

module Smt
  class Config
    def self.load
      File.exist?("#{Dir.home}/.smtrc.yml") && YAML.load_file("#{Dir.home}/.smtrc.yml")
    end
  end
end
