require_relative '../lib/setting'

module ShameBot; module Commands
  class Modify < SlackRubyBot::Commands::Base

    command 'add user' do |client, data, match|
      user, team = match['expression'].split(' to ').map(&:strip)
      response = set.add_user(user.capitalize, team.upcase)
      client.say(channel: data.channel, text: response)
    end

    command 'add team' do |client, data, match|
      team = match['expression'].strip.upcase
      response = set.add_team(team)
      client.say(channel: data.channel, text: response)
    end

    command 'remove user' do |client, data, match|
      user = match['expression'].strip.capitalize
      response = set.remove_user(user)
      client.say(channel: data.channel, text: response)
    end

    command 'remove team' do |client, data, match|
      team = match['expression'].strip.upcase
      response = set.remove_team(team)
      client.say(channel: data.channel, text: response)
    end

    class << self
      def set
        ShameBot::Lib::Setting.new
      end
    end

  end
end; end
