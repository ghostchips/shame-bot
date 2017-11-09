require 'spec_helper'

describe ShameBot::Lib::Getting do
  
  let(:existing_user) { 'Micah' }
  let(:new_user)      { 'Trevor' }
  let(:existing_team) { 'DEVS' }
  let(:new_team)      { 'DIUS' }
  let(:reasons)       { ['Reason 1', 'Reason 2'] }
  
  let(:no_team_error) { "#{new_team} not listed as team" }
  let(:no_user_error) { "#{new_user} not listed as user" }
  
  subject { ShameBot::Lib::Getting.new }
  
  before(:each) do
    yaml_parse = YAML.load_file("spec/wall_of_shame_spec.yaml")
    allow(YAML).to receive(:load_file).with(anything) { yaml_parse }
  end
  
  after(:each) do
    SpecHelper.reset_data
    SpecHelper.clear_errors 
  end
  
  it 'lists users on wall of shame' do
    expect(subject.list_users).to eq "Micah\nBono\nSam"
  end
  
  it 'lists teams on wall of shame' do
    expect(subject.list_teams).to eq "DEVS\nOPS"    
  end
  
  it 'list user shamings' do
    expect(subject.list_shamings(existing_user)).to eq "Reason 1.\nReason 2."
    expect(subject.list_shamings(new_user)).to eq no_user_error
  end
  
  it 'list team shamings' do
    expect(subject.list_team_shamings(existing_team)).to eq "Micah: Reason 1. Reason 2.\nBono: Reason 1."    
    expect(subject.list_team_shamings(new_team)).to eq no_team_error     
  end
    
  it 'count number of shamings for user' do
    expect(subject.count_user_shamings(existing_user)).to eq 2
    expect(subject.count_user_shamings(new_user)).to eq no_user_error    
  end
  
  it 'count number of team shamings' do
    expect(subject.count_team_shamings(existing_team)).to eq 3
    expect(subject.count_team_shamings(new_team)).to eq no_team_error     
  end
  
end