require 'spec_helper'

describe ShameBot::Commands::Modify do

  subject(:app) { ShameBot::Bot.instance }

  before(:each) do
    yaml_parse = YAML.load_file("spec/wall_of_shame_spec.yaml")
    allow(YAML).to receive(:load_file).with(anything) { yaml_parse }
  end

  after(:each) do
    SpecHelper.reset_data
    SpecHelper.clear_errors
  end

  it 'adds a user' do
    expect(message: "#{SlackRubyBot.config.user} add user Trevor to DEVS", channel: 'channel').to respond_with_slack_message "Trevor added to DEVS team"
  end

  it 'adds a team' do
    expect(message: "#{SlackRubyBot.config.user} add team DIUS", channel: 'channel').to respond_with_slack_message "DIUS added as team"
  end

  it 'removes a user' do
    expect(message: "#{SlackRubyBot.config.user} remove user Micah", channel: 'channel').to respond_with_slack_message "Micah removed from DEVS team"
  end

  it 'removes a team' do
    expect(message: "#{SlackRubyBot.config.user} remove team DEVS", channel: 'channel').to respond_with_slack_message "DEVS team removed from Wall of Shame"
  end


end
