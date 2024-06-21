require 'pry'

describe Smt::Options do
  it 'parses the time option' do
    ARGV = %w[-t 12:00]
    a, b = Smt::Options.new.parse!
  end
end