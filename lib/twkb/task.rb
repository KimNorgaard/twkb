require 'json'

module TWKB
  module Task
    def Task.all(udas = {})
      f_udas = udas.map {|k,v| "#{k}:#{v}"}.join(' ')
      cmd = "task rc.verbose=nothing rc.json.array=yes #{f_udas} export"
      IO.popen(cmd, 'r:UTF-8') { |output|
        JSON.parse(output.read)
      }
    end
  end
end
