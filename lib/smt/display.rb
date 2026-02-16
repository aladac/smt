# frozen_string_literal: true

module Smt
  class Display
    BOX = {
      tl: '┌', tr: '┐', bl: '└', br: '┘',
      h: '─', v: '│',
      lm: '├', rm: '┤', tm: '┬', bm: '┴', cross: '┼'
    }.freeze

    def self.table(entries:, format:, time:)
      rows = entries.map do |entry|
        {
          emoji: entry[:emoji],
          label: time.strftime(entry[:label]),
          time: time.in_time_zone(entry[:time_zone]).strftime(format),
          color: entry[:color].to_sym
        }
      end

      emoji_w = 2
      label_w = rows.map { |r| r[:label].length }.max
      time_w = rows.map { |r| r[:time].length }.max

      puts top_border(emoji_w, label_w, time_w)
      rows.each_with_index do |row, i|
        puts row_line(row, emoji_w, label_w, time_w)
        puts mid_border(emoji_w, label_w, time_w) unless i == rows.length - 1
      end
      puts bottom_border(emoji_w, label_w, time_w)
    end

    def self.top_border(ew, lw, tw)
      "#{BOX[:tl]}#{BOX[:h] * (ew + 2)}#{BOX[:tm]}#{BOX[:h] * (lw + 2)}#{BOX[:tm]}#{BOX[:h] * (tw + 2)}#{BOX[:tr]}"
    end

    def self.mid_border(ew, lw, tw)
      "#{BOX[:lm]}#{BOX[:h] * (ew + 2)}#{BOX[:cross]}#{BOX[:h] * (lw + 2)}#{BOX[:cross]}#{BOX[:h] * (tw + 2)}#{BOX[:rm]}"
    end

    def self.bottom_border(ew, lw, tw)
      "#{BOX[:bl]}#{BOX[:h] * (ew + 2)}#{BOX[:bm]}#{BOX[:h] * (lw + 2)}#{BOX[:bm]}#{BOX[:h] * (tw + 2)}#{BOX[:br]}"
    end

    def self.row_line(row, ew, lw, tw)
      emoji_cell = row[:emoji] ? " #{row[:emoji]} " : ' ' * (ew + 2)
      label_cell = " #{row[:label].ljust(lw)} "
      time_cell = " #{row[:time].ljust(tw)} "

      "#{BOX[:v]}#{emoji_cell}#{BOX[:v]}#{label_cell.colorize(row[:color])}#{BOX[:v]}#{time_cell.colorize(row[:color])}#{BOX[:v]}"
    end

    private_class_method :top_border, :mid_border, :bottom_border, :row_line
  end
end
