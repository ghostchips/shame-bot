require 'spec_helper'

describe ShameBot::Commands::Shame do
  
  let(:data) do
    { 'DEVS' => { "Micah" => ["Reason 1", "Reason 2"], "Bono"=> ["Reason 1"] },
      'OPS'  => { "Sam" => ["Reason 1", "Reason 2"] } }
  end

  subject(:app) { ShameBot::Bot.instance }

  before(:each) do
    allow(YAML).to receive(:load_file).with(anything) { data }
    allow(File).to receive(:open).with("wall_of_shame.yaml", "w") { puts 'writing to yaml...'; true }
  end
  
  after(:each)  { SpecHelper.reset_data }

  it 'shames a user' do
    expect(message: "#{SlackRubyBot.config.user} shame Micah for reason", channel: 'channel').to respond_with_slack_message "Shame!\nShame!\nShame!\nMicah shamed for reason."
  end

  it 'shames a user for multiple reasons' do
    expect(message: "#{SlackRubyBot.config.user} shame Micah for reason. reason 2", channel: 'channel').to respond_with_slack_message "Shame!\nShame!\nShame!\nMicah shamed for reason; reason 2."
  end

  it 'list a users shamings' do
    expect(message: "#{SlackRubyBot.config.user} list user shamings for Micah", channel: 'channel').to respond_with_slack_message "Reason 1\nReason 2"
  end

  it 'list a users shamings with no shamings' do
    data['DEVS']['Trevor'] = []
    expect(message: "#{SlackRubyBot.config.user} list user shamings for Trevor", channel: 'channel').to respond_with_slack_message "Trevor is free of shame"
  end


  it 'list a teams shamings' do
    expect(message: "#{SlackRubyBot.config.user} list team shamings for DEVS", channel: 'channel').to respond_with_slack_message "Micah:\n   Reason 1\n   Reason 2\nBono:\n   Reason 1"
  end

  it 'list a teams shamings with no team shamings' do
    data['TESTING'] = {}
    data['TESTING']['Steven'] = []
    expect(message: "#{SlackRubyBot.config.user} list team shamings for TESTING", channel: 'channel').to respond_with_slack_message "TESTING is free of shame"
  end

  it 'lists teams ranked by shamings' do
    expect(message: "#{SlackRubyBot.config.user} list team rankings", channel: 'channel').to respond_with_slack_message "DEVS: 3\nOPS: 2"
  end

  it 'lists users ranked by shamings' do
    expect(message: "#{SlackRubyBot.config.user} list user rankings", channel: 'channel').to respond_with_slack_message "Sam: 2\nMicah: 2\nBono: 1"
  end
  
  context 'no data' do
    let(:data) { {} }
    
    it 'team rakings returns no data message' do
      expect(message: "#{SlackRubyBot.config.user} list team rankings", channel: 'channel').to respond_with_slack_message "No teams to display. Please add teams."
    end
    
    it 'user rakings returns no data message' do
      expect(message: "#{SlackRubyBot.config.user} list user rankings", channel: 'channel').to respond_with_slack_message "No users to display. Please add users."
    end
    
  end
end
