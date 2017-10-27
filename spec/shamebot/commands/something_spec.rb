require 'spec_helper'

describe ShameBot::Commands::Something do
  
  subject(:app) { ShameBot::Bot.instance }
  
  it 'returns 4' do
    expect(message: "#{SlackRubyBot.config.user} something", channel: 'channel').to respond_with_slack_message '4'
  end
end