# frozen_string_literal: true

require_relative "smt/version"
require_relative "smt/config"
require_relative "smt/options"
require_relative "smt/display"

module Smt
  class Error < StandardError; end

  DEFAULT_FORMAT = "%Y-%m-%d %H:%M:%S"
end
