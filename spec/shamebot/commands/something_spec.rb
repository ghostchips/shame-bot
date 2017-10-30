require 'spec_helper'

describe ShameBot::Commands::Shame do
  
  subject(:app) { ShameBot::Bot.instance }
  
  it 'returns the user' do
    expect(message: "#{SlackRubyBot.config.user} shame @somebody for reason", channel: 'channel').to respond_with_slack_message '@somebody'
  end
end