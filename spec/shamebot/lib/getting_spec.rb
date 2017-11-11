require 'spec_helper'

describe ShameBot::Lib::Getting do

  let(:existing_user) { 'Micah' }
  let(:new_user)      { 'Trevor' }
  let(:existing_team) { 'DEVS' }
  let(:new_team)      { 'DIUS' }

  let(:no_team_error) { "#{new_team} not listed as team" }
  let(:no_user_error) { "#{new_user} not listed as user" }

  let(:set)     { ShameBot::Lib::Setting.new }
  subject(:get) { ShameBot::Lib::Getting.new }

  before(:each) do
    yaml_parse = YAML.load_file("spec/wall_of_shame_spec.yaml")
    allow(YAML).to receive(:load_file).with(anything) { yaml_parse }
  end

  after(:each) do
    SpecHelper.reset_data
    SpecHelper.clear_errors
  end

  it 'lists users on wall of shame' do
    expect(get.users).to eq %w[Micah Bono Sam]
  end

  it 'lists teams on wall of shame' do
    expect(get.teams).to eq %w[DEVS OPS]
  end

  it 'list user shamings' do
    expect(get.user_shamings(existing_user)).to eq ["Reason 1","Reason 2"]
    expect(get.user_shamings(new_user)).to eq no_user_error
  end

  it 'list team shamings' do
    expect(get.team_shamings(existing_team)).to eq ["Micah: Reason 1\nReason 2","Bono: Reason 1"]
    expect(get.team_shamings(new_team)).to eq no_team_error
  end

  it 'count number of shamings for user' do
    expect(get.count_user_shamings(existing_user)).to eq 2
    expect(get.count_user_shamings(new_user)).to eq no_user_error
  end

  it 'count number of team shamings' do
    expect(get.count_team_shamings(existing_team)).to eq 3
    expect(get.count_team_shamings(new_team)).to eq no_team_error
  end

  it 'displays teams and shamings count sorted by shame count' do
    set.shame('Sam', 'making a mistake', 'making another mistake')
    expect(get.teams_by_shamings).to eq ["OPS: 4","DEVS: 3"]
  end

  it 'displays user and shamings count sorted by shame count' do
    set.shame('Micah', 'making a mistake')
    expect(get.users_by_shamings).to eq ["Micah: 3","Sam: 2","Bono: 1"]
  end

end
