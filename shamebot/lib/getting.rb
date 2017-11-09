require 'wall_of_shame'

module ShameBot; module Lib
  
  class Getting
    
    def initialize
      WallOfShame.data
      WallOfShame.errors.clear
    end
    
    def list_users
      WallOfShame.users.join("\n")
    end
    
    def list_teams
      WallOfShame.teams.join("\n")
    end
    
    def list_shamings(user_name)
      shamings = WallOfShame.user_data(user_name)
      shamings ? shamings.join(".\n") << '.' : display_errors
    end
    
    def list_team_shamings(team_name)
      if team = WallOfShame.team_data(team_name)
        team.map { |user, shamings| "#{user}: #{shamings.join('. ')}." }.join("\n")
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
    
    private
    
    def display_errors
      WallOfShame.errors.join("\n").tap { |_| WallOfShame.errors.clear }
    end
    
  end
  
end; end
