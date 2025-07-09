# frozen_string_literal: true

ARGV = %w[-t 12:00] # rubocop:disable Style/MutableConstant

RSpec.describe Smt::Options do
  it "parses the time option" do
    Smt::Options.new.parse!
  end
end
