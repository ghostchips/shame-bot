require_relative 'shamebot/connection'
require 'yaml'

module WallOfShame

  class << self
    
    def add_team(team)
      return false if team_exists?(team)
      data[team] = {}
      !!update_yaml
    end

    def add_user(user, team)
      return false unless team_exists?(team)
      return false if user_in_a_team?(user)
      data[team][user] = []
      !!update_yaml
    end

    def remove_team(team)
      return false unless team_exists?(team)
      data.delete(team)
      !!update_yaml
    end

    def remove_user(user)
      return false unless user_exists?(user)
      data[user_team(user)].delete(user)
      !!update_yaml
    end

    def user_data(user)
      return false unless user_exists?(user)
      data[user_team(user)][user]
    end

    def team_data(team)
      return false unless team_exists?(team)
      data[team]
    end

    def shame(user, *reasons)
      return false unless user_exists?(user)
      reasons.each { |reason| data[user_team(user)][user] << reason }
      !!update_yaml
    end
    
    def user_team(user)
      data.map { |team, users| team if users[user] }.compact.first
    end

    def errors
      @@errors ||= []
    end

    def data
      @@data ||= read_yaml #|| generate_yaml
    end

    private
        
    def team_exists?(team)
      teams.include?(team).tap do |includes_team| 
        errors << includes_team ? "#{team} already listed as team" : "#{team} not listed as team"
      end
    end
    
    def user_exists?(user)
      users.include?(user).tap do |includes_user| 
        errors << "#{user} not listed as user" unless includes_user
      end
    end
    
    def user_in_a_team?(user)
      user_team(user).tap do |team| 
        errors << "#{user} already listed in #{team}" if team
      end
    end

    def teams
      data.keys
    end

    def users
      data.map { |_, v| v.keys }.flatten
    end
    
    def users_in_team(team)
      data[team].keys
    end
    
    def read_yaml
      YAML.load_file("wall_of_shame.yaml").tap do |file|
        puts 'reading from yaml...' if file
      end
    end

    def update_yaml
      write_to_yaml #if data != read_yaml
    end

    # create yaml file from google drive... do this later
    def generate_yaml
      drive_worksheet.each do |row|
        @@data[row[0]] = {} unless @@data[row[0]]
        @@data[row[0]][row[1]] = row[2..-1]
      end
      write_to_yaml
    end

    def drive_worksheet
      ShameBot::Data::Connection.new.load_worksheet
    end

    def write_to_yaml(file_location = "wall_of_shame.yaml")
      File.open(file_location, "w") do |file|
        puts 'writing to yaml...'
        file.write @@data.to_yaml
      end
    end
  end

end
