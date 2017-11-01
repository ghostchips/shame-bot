require_relative 'shamebot/connection'
require 'yaml'

module WallOfShame
    
  class << self

    def teams
      data.keys
    end
    
    def users 
      data.map { |_, v| v.keys }.flatten
      
      # move to access class
      # users = data.map { |_, v| v.keys }
      # teams = data.keys
      # teams.zip(users)
      #   .map(&:flatten)
      #   .map { |t| t.join(', ') }
      #   .map { |t| t.sub(/,/, ':') }
      #   .join("\n")
    end
    
    def add_team(team_name)
      team_name = team_name.upcase
      return false if data[team_name].tap do |team| 
        errors << "#{team_name} already listed as team" if team
      end
      data[team_name] = {}
      !!data[team_name]
    end
    
    def add_user(user_name, team_name)
      team_name = team_name.upcase
      user_name = user_name.capitalize
      return false unless fetch_team_data(team_name)      
      return false if data[team_name][user_name].tap do |user|
        errors << "#{user_name} already listed under #{team_name}" if user
      end
      data[team_name][user_name] = []
      !!data[team_name][user_name]
    end
    
    def fetch_user_data(user_name)
      user_data = teams.map { |team| data[team][user_name.capitalize] }.flatten.compact
      return false if user_data.empty?.tap do |user|
        errors << "#{user_name} not listed as user" if user_data.empty?
      end
      user_data
    end
    
    def fetch_team_data(team_name)
      team_data = data[team_name.upcase]
      return false unless team_data.tap do |team|
        errors << "#{team_name} not listed as team" unless team
      end
      team_data
    end
    
    # def list_shamings(name)
    #   case
    #   when teams.include?(name.upcase)
    #     fetch_team_data(name)
    #   when users.include?(name.capitalize)
    #     fetch_user_data(name)
    #   end
    # end
    
    # add these to lookup class
    # def team_shamings(team_name)
    #   data[team_name.upcase].values.flatten
    # end
    # 
    # def count_team_shamings(team_name)
    #   team_name = team_name.upcase
    #   data[team_name]
    # end
    
    def shame(user_name, team_name = nil)
      return false unless team_name.nil? || !fetch_team_data(team_name)
      return false unless fetch_user_data(user_name)
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
      data
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
