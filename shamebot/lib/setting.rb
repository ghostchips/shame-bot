require 'wall_of_shame'

module ShameBot; module Lib

  class Setting

    def initialize
      WallOfShame.data
      WallOfShame.errors.clear
    end

    def shame(user, *reasons)
      if WallOfShame.shame(user, *reasons)
        "#{user} shamed for #{reasons.size == 1 ? reasons.first : reasons.join('; ')}."
      else
        display_errors
      end
    end

    def add_user(user, team)
      if WallOfShame.add_user(user, team)
        "#{user} added to #{team} team"
      else
        display_errors
      end
    end

    def add_team(team)
      if WallOfShame.add_team(team)
        "#{team} added as a team"
      else
        display_errors
      end
    end

    def remove_user(user)
      user_team = WallOfShame.user_team(user)
      if WallOfShame.remove_user(user)
        "#{user} removed from #{user_team} team"
      else
        user_team ? display_errors : display_errors.split("\n").last
      end
    end

    def remove_team(team)
      if WallOfShame.remove_team(team)
        "#{team} team removed from Wall of Shame"
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
