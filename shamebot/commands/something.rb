module ShameBot; module Commands
  class Something < SlackRubyBot::Commands::Base
    command 'something' do |client, data, _match|
      client.say(channel: data.channel, text: '4')
    end
  end
end; end