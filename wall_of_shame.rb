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
      return false if user_in_team?(user, team) || user_in_other_team?(user, team)
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

    def errors(arg, arg2 = nil)
      [
        "#{arg} not listed as user",
        "#{arg} not listed as team",
        "#{arg} already listed as team",
        "#{arg} already listed under #{arg2}"
      ]
      @@errors ||= []
    end

    def data
      @@data ||= read_yaml #|| generate_yaml
    end

    private
    
    def teams
      data.keys
    end

    def users
      data.map { |_, v| v.keys }.flatten
    end
    
    def users_in_team(team)
      data[team].keys
    end
    
    def user_in_other_team?(user, team)
      remaining_teams = teams - [team]
      other_user_teams = remaining_teams.select { |t| data[t].include?(user) }
      other_user_teams.any?
    end
    
    def user_in_team?(user, team)
      users_in_team(team).include?(user)
    end
    
    def user_team(user)
      data.map { |team, users| team if users[user.capitalize] }.compact.first
    end
    
    def team_exists?(team)
      teams.include?(team)
    end
    
    def user_exists?(user)
      users.include?(user)
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
  
  ERRORS = [
    ''
  ]

end
