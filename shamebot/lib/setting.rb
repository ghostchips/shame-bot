require 'wall_of_shame'

module ShameBot; module Lib

  class Setting

    def initialize
      WallOfShame.data
      WallOfShame.errors.clear
    end

    def shame(user_name, *reasons)
      if WallOfShame.shame(user_name, *reasons)
        "#{user_name.capitalize} shamed for #{reasons.size == 1 ? reasons.first : reasons.join('; ')}."
      else
        display_errors
      end
    end

    def add_user(user_name, team_name)
      if WallOfShame.add_user(user_name, team_name)
        "#{user_name.capitalize} added to #{team_name.upcase}"
      else
        display_errors
      end
    end

    def add_team(team_name)
      if WallOfShame.add_team(team_name)
        "#{team_name.upcase} added as team"
      else
        display_errors
      end
    end

    def remove_user(user_name)
      user_team = WallOfShame.user_team(user_name)
      if WallOfShame.remove_user(user_name)
        "#{user_name.capitalize} removed from #{user_team}"
      else
        user_team ? display_errors : display_errors.split("\n").last
      end
    end

    def remove_team(team_name)
      if WallOfShame.remove_team(team_name)
        "#{team_name.upcase} removed from Wall of Shame"
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
