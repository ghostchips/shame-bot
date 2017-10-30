require_relative 'shamebot/connection'
require 'yaml'

class WallOfShame
  
  @@data = {}
  
  class << self
        
    def data
      @@data
    end
    
    def teams
      fetch_data.keys.join(', ')
    end
    
    def users
      
    end
    
    def add(args = {})
      user = args[:user].to_sym
      @@data[user] ? "#{user} already on Wall of Shame" : @@data[user] = ''
    end
    
    def shame(args = {})
      args[:user]
      args[:reason]
    end
    
    private
    
    def fetch_data
      @@data && @@data.any? ? @@data : read_yaml #|| generate_yaml
    end
    
    def read_yaml
      @@data = YAML.load(File.open("wall_of_shame.yaml")) 
    end
    
    def generate_yaml
      drive_worksheet.each do |row|
        @@data[row[0]] = {} unless @@data[row[0]]
        @@data[row[0]][row[1]] = row[2..-1]
      end
      write_to_yaml
      @@data
    end
    
    def drive_worksheet
      ShameBot::Data::Connection.new.load_worksheet
    end
    
    def write_to_yaml
      File.open("wall_of_shame.yaml","w") do |file|
        file.write @@data.to_yaml
      end 
    end
  end
  
end













