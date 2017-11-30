require 'spec_helper'

describe ShameBot::Commands::Modify do
  
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

  it 'adds a user' do
    expect(message: "#{SlackRubyBot.config.user} add user Trevor to DEVS", channel: 'channel').to respond_with_slack_message "Trevor added to DEVS team"
  end

  it 'adds a team' do
    expect(message: "#{SlackRubyBot.config.user} add team DIUS", channel: 'channel').to respond_with_slack_message "DIUS added as a team"
  end

  it 'removes a user' do
    expect(message: "#{SlackRubyBot.config.user} remove user Micah", channel: 'channel').to respond_with_slack_message "Micah removed from DEVS team"
  end

  it 'removes a team' do
    expect(message: "#{SlackRubyBot.config.user} remove team DEVS", channel: 'channel').to respond_with_slack_message "DEVS team removed from Wall of Shame"
  end
  
  context 'no data saved' do
    let(:data) { {} }
    
    it 'adds a user' do
      expect(message: "#{SlackRubyBot.config.user} add user Trevor to DEVS", channel: 'channel').to respond_with_slack_message "DEVS is not listed as a team"
    end
    
    it 'removes a user' do
      expect(message: "#{SlackRubyBot.config.user} remove user Micah", channel: 'channel').to respond_with_slack_message "Micah is not listed as a user"
    end
    
    it 'removes a team' do
      expect(message: "#{SlackRubyBot.config.user} remove team DEVS", channel: 'channel').to respond_with_slack_message "DEVS is not listed as a team"
    end
  end

end
