require_relative '../helpers/shameing'

module ShameBot; module Commands
  class Shame < SlackRubyBot::Commands::Base
    command 'shame' do |client, data, match|
      user, reason = match['expression'].split(' for ')
      # shameing = ShameBot::Data::Shameing.new(user: user, reason: reason)
      client.say(channel: data.channel, text: user)
    end
  end
end; end
