require 'wall_of_shame'

module ShameBot; module Lib

  class Getting

    def initialize
      WallOfShame.data
      WallOfShame.errors.clear
    end

    def users
      WallOfShame.users
    end

    def teams
      WallOfShame.teams
    end

    def user_shamings(user_name)
      WallOfShame.user_data(user_name) || display_errors
    end

    def team_shamings(team_name)
      if team = WallOfShame.team_data(team_name)
        return [] if team.select {|user, shamings| shamings.any?}.empty?
        team.map { |user, shamings| "#{user}:\n   #{shamings.join("\n   ")}" }
      else
        display_errors
      end
    end

    def count_user_shamings(user_name)
      shamings = WallOfShame.user_data(user_name)
      shamings ? shamings.size : display_errors
    end

    def count_team_shamings(team_name)
      if team_shamings = WallOfShame.team_data(team_name)
        team_shamings.map { |_, shamings| shamings.size }.reduce(&:+)
      else
        display_errors
      end
    end

    def teams_by_shamings
      return [] if teams_shaming_hash.empty?
      teams_shaming_hash.map { |team, count| "#{count}#{team}" }.sort.reverse
        .map { |team| team[1..-1] }
        .map { |team|"#{team}: #{teams_shaming_hash[team]}" }
    end

    def users_by_shamings
      return [] if users_shaming_hash.empty?
      users_shaming_hash.map { |user, count| "#{count}#{user}" }.sort.reverse
        .map { |user| user[1..-1] }
        .map { |user| "#{user}: #{users_shaming_hash[user]}" }
    end

    private

    def display_errors
      WallOfShame.errors.join("\n").tap { |_| WallOfShame.errors.clear }
    end

    def teams_shaming_hash
      {}.tap do |shame_count|
        WallOfShame.teams.each do |team|
          shame_count[team] = count_team_shamings(team) if team
        end
      end
    end

    def users_shaming_hash
      {}.tap do |shame_count|
        WallOfShame.users.each do |user|
          shame_count[user] = count_user_shamings(user) if user
        end
      end
    end

  end

end; end
