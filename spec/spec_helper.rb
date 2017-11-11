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
    end
  end
  
  
end