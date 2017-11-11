require 'spec_helper'

describe ShameBot::Lib::Setting do
  
  let(:existing_user) { 'Micah' }
  let(:new_user)      { 'Trevor' }
  let(:existing_team) { 'DEVS' }
  let(:new_team)      { 'DIUS' }
  let(:reasons)       { ['Reason 1', 'Reason 2'] }
  
  let(:no_team_error) { "#{new_team} not listed as team" }
  let(:no_user_error) { "#{new_user} not listed as user" }
  
  subject { ShameBot::Lib::Setting.new }
  
  before(:each) do
    yaml_parse = YAML.load_file("spec/wall_of_shame_spec.yaml")
    allow(YAML).to receive(:load_file).with(anything) { yaml_parse }
  end
  
  after(:each) do
    SpecHelper.reset_data
    SpecHelper.clear_errors 
  end
  
  context 'Shaming' do
    
    it 'shame an existing user' do
      expect(subject.shame(existing_user, reasons.first)).to eq "Micah shamed for Reason 1."
      expect(subject.shame(existing_user, *reasons)).to eq "Micah shamed for Reason 1; Reason 2."
    end
    
    it 'shame new user' do
      expect(subject.shame(new_user, reasons)).to eq no_user_error
    end
    
  end
  
  context 'Setting users and teams' do
    it 'adding a new user to an existing team' do
      expect(subject.add_user(new_user, existing_team)).to eq "#{new_user} added to #{existing_team}"
    end
    
    it 'adding user to new team' do
      expect(subject.add_user(existing_user, new_team)).to eq no_team_error
      expect(subject.add_user(new_user, new_team)).to eq no_team_error
    end
    
    it 'adding existing user to existing team' do
      expect(subject.add_user(existing_user, existing_team)).to eq "#{existing_user} already listed under #{existing_team}"
    end
    
    it 'adding new team' do
      expect(subject.add_team(new_team)).to eq "#{new_team} added as team"
    end
    
    it 'adding existing team' do
      expect(subject.add_team(existing_team)).to eq "#{existing_team} already listed as team"
    end
  end
  
end