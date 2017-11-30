require_relative '../lib/setting'
require_relative '../lib/getting'

module ShameBot; module Commands
  class Shame < SlackRubyBot::Commands::Base

    command 'shame' do |client, data, match|
      user, reasons = match[:expression].split(' for ')
      reasons = reasons.split('. ') if reasons.include?('.')
      response = set.shame(user.capitalize, *reasons)
      client.say(channel: data.channel, text: "Shame!\nShame!\nShame!\n#{response}")
    end

    command 'list user shamings' do |client, data, match|
      user = match[:expression][4..-1].capitalize
      shamings = get.user_shamings(user)
      response = shamings.empty? ? "#{user} is free of shame" : shamings.join("\n")
      client.say(channel: data.channel, text: response)
    end

    command 'list team shamings' do |client, data, match|
      team = match[:expression][4..-1].upcase
      shamings = get.team_shamings(team)
      response = shamings.empty? ? "#{team} is free of shame" : shamings.join("\n")
      client.say(channel: data.channel, text: response)
    end

    command 'list team rankings' do |client, data, match|
      rankings = get.teams_by_shamings
      response = rankings.empty? ? "No teams to display. Please add teams." : rankings.join("\n")
      client.say(channel: data.channel, text: response)
    end

    command 'list user rankings' do |client, data, match|
      rankings = get.users_by_shamings
      response = rankings.empty? ? "No users to display. Please add users." : rankings.join("\n")
      client.say(channel: data.channel, text: response)
    end

    class << self
      def get
        ShameBot::Lib::Getting.new
      end

      def set
        ShameBot::Lib::Setting.new
      end
    end

  end
end; end
