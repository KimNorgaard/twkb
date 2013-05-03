require 'parseconfig'

module TWKB
  class Config
    attr_reader :stage_names
    attr_accessor :stages

    def initialize
      read
      prepare
      build_stages
    end

    def [](val)
      @config[val]
    end

    private

    def defaults
      {
        'twkb.view.cell_width' => '15',
        'twkb.view.stages.alignment' => 'center',
        'twkb.view.done_tasks' => '5',
        'twkb.stages' => 'backlog,next,inprogress,waiting,done',
        'twkb.stages.backlog.wip' => '10',
        'twkb.stages.backlog.label.value' => 'Backlog',
        'twkb.stages.next.wip' => '5',
        'twkb.stages.next.label.value' => 'Next',
        'twkb.stages.inprogress.wip' => '3',
        'twkb.stages.inprogress.label.value' => 'In progress',
        'twkb.stages.waiting.wip' => '6',
        'twkb.stages.waiting.label.value' => 'Waiting',
        'twkb.stages.done.label.value' => 'Done'
      }    
    end

    def read
      begin
        user_config = ParseConfig.new("#{Dir.home}/.taskrc")
        if user_config.params['twkb.stages'] and user_config.params['twkb.stages'].empty?
          user_config.params['twkb.stages'] = defaults['twkb.stages']
        end
        @config = defaults.merge(user_config.params)
      rescue Errno::EACCES
        puts "Failed to read the configuration. Using defaults."
        @config = defaults
      end
    end

    def prepare
      @config.keys.each do |k|
        # Convert numbers to integers for convenience
        if @config[k] =~ /^\d+$/
          @config[k] = @config[k].to_i
        end
        # Remove the 'twkb' part for convenience
        @config[k.gsub(/^twkb\.(.*)/, '\1')] = @config.delete(k)
      end
    end

    def build_stages
      @stage_names = self['stages'].split(',')
      @stages = {}
      @stage_names.each do |stage|
        @stages[stage] = {
          :tasks => [],
          :wip   => self["stages.#{stage}.wip"].to_i || nil,
          :label => {
            :value     => self["stages.#{stage}.label.value"] || stage,
            :alignment => (self["stages.#{stage}.label.alignment"] || self["view.stages.alignment"]).to_sym
          }
        }
      end
    end

  end
end
