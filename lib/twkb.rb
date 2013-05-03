require 'twkb/config'
require 'twkb/task'
require 'twkb/formatter'

module TWKB
  class App
    attr_accessor :config
    attr_accessor :board_name

    def initialize(options)
      @config = TWKB::Config.new
      @board_name = get_board_name options[:board_name]
      populate_stages
    end

    def print_table
      formatter = TWKB::Formatter.new(:stages => @config.stages, :cell_width => @config['view.cell_width'])
      puts formatter.table
    end

    private
    def get_board_name(name = nil)
      name || @config['board_name'] || 'personal'
    end

    def populate_stages
      tasks = TWKB::Task.all(:board => @board_name)
      @config.stage_names.each do |stage|
        @config.stages[stage][:tasks] = tasks.select{|task|
          task['stage'] == stage && task['status'] == 'pending'
        }.sort_by{|k| k['urgency']}.reverse

        # Truncate headers to match cell width
        @config.stages[stage][:label][:value] = @config.stages[stage][:label][:value][0..@config['view.cell_width']]

        if @config.stages[stage][:wip]
          label_value = "\n(#{@config.stages[stage][:tasks].length}/#{@config.stages[stage][:wip]})"
          @config.stages[stage][:label][:value] << label_value[0..@config['view.cell_width']]
        end
      end

      # 'Done' is special
      if @config.stage_names.include? 'done'
        @config.stages['done'][:tasks] = tasks.select{ |task|
          task['status'] == 'completed'
        }.sort_by{|k| k['end'] }.reverse[0..@config['view.done_tasks']-1]
      end
    end
  end
end
