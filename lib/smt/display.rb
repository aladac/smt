# frozen_string_literal: true

module Smt
  class Display
    def self.show(entry:, format:, max_length:, time:)
      time_display = time.in_time_zone(entry[:time_zone]).strftime(format)
      formatted_time_zone = time.strftime(entry[:label]).rjust(max_length)

      puts "#{formatted_time_zone} #{time_display}".colorize(entry[:color].to_sym)
    end
  end
end
