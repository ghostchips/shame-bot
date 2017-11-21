$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'slack-ruby-bot/rspec'
require 'shamebot'
require 'yaml'

class SpecHelper

  class << self
    def clear_errors
      WallOfShame.errors.clear
    end

    def reset_data
      WallOfShame.class_variable_set(:@@data, nil)
      # WallOfShame.class_variable_set(:@@yaml, nil)
      File.open('wall_of_shame_spec.yaml', "w") do |file|
        puts 'writing to yaml...'
        file.write sample_data.to_yaml
      end
    end

    def sample_data
      {
        "DEVS" =>
          { "Micah" => ["Reason 1", "Reason 2"],
            "Bono"  => ["Reason 1"] },
        "OPS" =>
          { "Sam" => ["Reason 1", "Reason 2"] }
        }
    end
  end
end
