require 'spec_helper'

describe ShameBot::Commands::Shame do
  
  subject(:app) { ShameBot::Bot.instance }
  
  before(:each) do
    yaml_parse = YAML.load_file("spec/wall_of_shame_spec.yaml")
    allow(YAML).to receive(:load_file).with(anything) { yaml_parse }
  end
  
  after(:each) do
    SpecHelper.reset_data
    SpecHelper.clear_errors 
  end
  
  it 'shames a user' do
    expect(message: "#{SlackRubyBot.config.user} shame Micah for reason", channel: 'channel').to respond_with_slack_message "Micah shamed for reason."
  end
  
  it 'list a users shamings' do
    expect(message: "#{SlackRubyBot.config.user} list shamings for Micah", channel: 'channel').to respond_with_slack_message "Reason 1.\nReason 2."
  end
end