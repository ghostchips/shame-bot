require_relative '../lib/setting'
require_relative '../lib/getting'

module ShameBot; module Commands
  class Shame < SlackRubyBot::Commands::Base

    command 'shame' do |client, data, match|
      user, reason = match['expression'].split(' for ')
      response = set.shame(user, reason)
      client.say(channel: data.channel, text: response)
    end

    command 'list user shamings' do |client, data, match|
      user = match['expression'][4..-1]
      response = get.user_shamings(user).join("\n")
      # require 'pry'; binding.pry;
      client.say(channel: data.channel, text: response)
    end

    command 'list team shamings' do |client, data, match|
      team = match['expression'][4..-1]
      response = get.team_shamings(team).join("\n")
      client.say(channel: data.channel, text: response)
    end

    command 'list team rankings' do |client, data, match|
      response = get.teams_by_shamings.join("\n")
      client.say(channel: data.channel, text: response)
    end

    command 'list user rankings' do |client, data, match|
      response = get.users_by_shamings.join("\n")
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
