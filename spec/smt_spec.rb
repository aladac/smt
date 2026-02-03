# frozen_string_literal: true

require "colorize"

RSpec.describe Smt, :verified do
  describe "VERSION" do
    it "is defined" do
      expect(Smt::VERSION).to eq("0.2.3")
    end
  end

  describe "DEFAULT_FORMAT" do
    it "is a strftime format string" do
      expect(Smt::DEFAULT_FORMAT).to eq("%Y-%m-%d %H:%M:%S")
    end
  end
end

RSpec.describe Smt::Config, :verified do
  describe ".load" do
    it "returns nil when config file is missing" do
      allow(File).to receive(:exist?).with(Smt::Config::CONFIG_PATH).and_return(false)

      expect(Smt::Config.load).to be_nil
    end

    it "loads a valid config file" do
      config_data = [{time_zone: "UTC", label: "UTC", color: "white"}]

      allow(File).to receive(:exist?).with(Smt::Config::CONFIG_PATH).and_return(true)
      allow(YAML).to receive(:safe_load_file)
        .with(Smt::Config::CONFIG_PATH, permitted_classes: [Symbol], symbolize_names: true)
        .and_return(config_data)

      result = Smt::Config.load

      expect(result).to eq(config_data)
    end
  end
end

RSpec.describe Smt::Options, :verified do
  describe "#parse!" do
    it "returns nils with no arguments" do
      stub_const("ARGV", [])

      input, format = Smt::Options.new.parse!

      expect(input).to be_nil
      expect(format).to be_nil
    end

    it "parses time option" do
      stub_const("ARGV", %w[-t 12:00])

      input, _format = Smt::Options.new.parse!

      expect(input).to eq("12:00")
    end

    it "parses format option" do
      stub_const("ARGV", %w[-f %H:%M])

      _input, format = Smt::Options.new.parse!

      expect(format).to eq("%H:%M")
    end

    it "parses both time and format" do
      stub_const("ARGV", %w[-t 12:00 -f %H:%M])

      input, format = Smt::Options.new.parse!

      expect(input).to eq("12:00")
      expect(format).to eq("%H:%M")
    end
  end
end

RSpec.describe Smt::Display, :verified do
  describe ".table" do
    let(:time) { Time.utc(2024, 1, 15, 12, 0, 0) }

    it "renders a table with box-drawing borders" do
      entries = [{time_zone: "UTC", label: "UTC", color: "white"}]

      output = capture_output do
        Smt::Display.table(entries: entries, format: "%H:%M:%S", time: time)
      end

      expect(output).to include("┌")
      expect(output).to include("└")
      expect(output).to include("12:00:00")
    end

    it "includes emoji in table rows" do
      entries = [{time_zone: "UTC", label: "UTC", color: "white", emoji: "🌍"}]

      output = capture_output do
        Smt::Display.table(entries: entries, format: "%H:%M:%S", time: time)
      end

      expect(output).to include("🌍")
      expect(output).to include("UTC")
    end

    it "renders mid-borders between multiple rows" do
      entries = [
        {time_zone: "UTC", label: "UTC", color: "white"},
        {time_zone: "US/Eastern", label: "Eastern", color: "red"}
      ]

      output = capture_output do
        Smt::Display.table(entries: entries, format: "%H:%M:%S", time: time)
      end

      expect(output).to include("├")
      expect(output).to include("┼")
    end
  end

  private

  def capture_output(&block)
    original_stdout = $stdout
    $stdout = StringIO.new
    block.call
    $stdout.string
  ensure
    $stdout = original_stdout
  end
end
