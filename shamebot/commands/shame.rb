require_relative '../lib/setting'
require_relative '../lib/getting'

module ShameBot; module Commands
  class Shame < SlackRubyBot::Commands::Base
    command 'shame' do |client, data, match|
      set = ShameBot::Lib::Setting.new
      user, reason = match['expression'].split(' for ')
      response = set.shame(user, reason)
      client.say(channel: data.channel, text: response)
    end
    
    command 'list shamings' do |client, data, match|
      get = ShameBot::Lib::Getting.new
      user = match['expression'][4..-1]
      response = get.list_shamings(user)
      client.say(channel: data.channel, text: response)
    end
    
    private
    
    def get
      
    end
    
    def set
      
    end
    
  end
end; end
