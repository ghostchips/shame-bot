require_relative 'shamebot/connection'
require 'yaml'

module WallOfShame
    
  class << self

    def teams
      data.keys.join(', ')
    end
    
    def users
      users = data.map { |_, v| v.keys }
      teams = data.keys
      teams.zip(users)
        .map(&:flatten)
        .map { |t| t.join(', ') }
        .map { |t| t.sub(/,/, ':') }
        .join("\n")
    end
    
    def add_team(team_name)
      team_name = team_name.upcase
      raise '' if data[team_name] # add error
      data[team_name] = {}
      !!data[team_name]
    end
    
    def add_user(user_name, team_name)
      user_name = user_name.capitalize
      team_name = team_name.upcase
      raise '' if data[team_name][user_name] # add error
      data[team_name][user_name] = []
      !!data[team_name][user_name]
    end
    
    def list_shamings(user_name)
      user_name = user_name.capitalize
      list = data.map {|_,v| v[user_name]}.flatten.compact
      list.join("\n")
    end
    
    def count_user_shamings(user_name)
      list_shamings(user_name).split("\n").size
    end
    
    def shame(user_name)
    end
    
    def errors
      @errors ||= []
    end
    
    private
    
    def data
      @@data ||= read_yaml #|| generate_yaml
    end
    
    def read_yaml
      puts 'reading from yaml...'
      @@data = YAML.load_file("wall_of_shame.yaml")
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













