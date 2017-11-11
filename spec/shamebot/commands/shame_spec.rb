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
    expect(message: "#{SlackRubyBot.config.user} list user shamings for Micah", channel: 'channel').to respond_with_slack_message "Reason 1\nReason 2"
  end

  it 'list a teams shamings' do
    expect(message: "#{SlackRubyBot.config.user} list team shamings for DEVS", channel: 'channel').to respond_with_slack_message "Micah: Reason 1\nReason 2\nBono: Reason 1"
  end

  it 'lists teams ranked by shamings' do
    expect(message: "#{SlackRubyBot.config.user} list team rankings", channel: 'channel').to respond_with_slack_message "DEVS: 3\nOPS: 2"
  end

  it 'lists users ranked by shamings' do
    expect(message: "#{SlackRubyBot.config.user} list user rankings", channel: 'channel').to respond_with_slack_message "Sam: 2\nMicah: 2\nBono: 1"
  end
end
