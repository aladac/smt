# frozen_string_literal: true

module Smt
  class Options
    BANNER = <<~BANNER
      Usage: smt [options]
    BANNER

    def initialize; end

    def time_opts(opts)
      opts.on('-t', '--time TIME', 'Time to convert') do |time|
        @input = time
      end
    end

    def format_opts(opts)
      opts.on('-f', '--format FORMAT', 'Time format') do |fmt|
        @format = fmt
      end
    end

    def help_opts(opts)
      opts.on('-h', '--help', 'Display this screen') do
        puts opts
        exit
      end
    end

    def list_opts(opts)
      opts.on('-l', '--list', 'List all timezones') do
        puts ActiveSupport::TimeZone.all.map(&:name)
        exit
      end
    end

    def for_parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: smt [options]'

        help_opts(opts)
        time_opts(opts)
        format_opts(opts)
        list_opts(opts)
      end
    end
  end
end
