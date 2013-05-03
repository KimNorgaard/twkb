require 'terminal-table'
require 'rainbow'

module TWKB
  class Formatter
    def initialize(options)
      raise ArgumentError, 'Missing :stages argument' unless options[:stages]
      raise ArgumentError, ':stages is not a Hash' unless options[:stages].is_a? Hash
      @cell_width   = options[:cell_width]
      @cell_width ||= 15
      @stages = options[:stages]
      prepare
    end

    def table
      stage_labels = @stages.keys.map{|k,v| @stages[k][:label]}
      Terminal::Table.new :headings => stage_labels, :rows => [@lanes]
    end

    private

    def color_box(text, width=15, fg=:black, bg=:white)
      lines = text.scan /.{1,#{width}}/
      lines.map!{|line| "#{line.ljust(width).background(bg).foreground(fg)}\n"}
      lines.join
    end

    def prepare
      @lanes = Array.new
      @stages.each do |k, v|
        tasks = v[:tasks]
        text = String.new
        # Makes sure empty columns have the correct cell width
        text << ' ' * @cell_width if tasks.count == 0
        tasks.each do |k, v|
          next unless k
          if k['status'] == 'completed'
            text << color_box("#{k['description']}", @cell_width)
          else
            text << color_box("#{k['id']}) #{k['description']}", @cell_width)
          end
          text << "\n"
        end
        @lanes << text
      end
    end
  end
end
