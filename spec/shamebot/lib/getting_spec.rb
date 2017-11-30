require 'spec_helper'

describe ShameBot::Lib::Getting do

  let(:existing_user) { 'Micah' }
  let(:new_user)      { 'Trevor' }
  let(:existing_team) { 'DEVS' }
  let(:new_team)      { 'DIUS' }
  let(:data) do
    { 'DEVS' => { "Micah" => ["Reason 1", "Reason 2"], "Bono"=> ["Reason 1"] },
      'OPS'  => { "Sam" => ["Reason 1", "Reason 2"] } }
  end  

  let(:no_team_error) { "#{new_team} is not listed as a team" }
  let(:no_user_error) { "#{new_user} is not listed as a user" }

  let(:set)     { ShameBot::Lib::Setting.new }
  subject(:get) { ShameBot::Lib::Getting.new }

  before(:each) do
    allow(YAML).to receive(:load_file).with(anything) { data }
    allow(File).to receive(:open).with("wall_of_shame.yaml", "w") { puts 'writing to yaml...'; true }
  end
  
  after(:each) { SpecHelper.reset_data }

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
    expect(get.team_shamings(existing_team)).to eq ["Micah:\n   Reason 1\n   Reason 2","Bono:\n   Reason 1"]
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
  
  context 'with no saved data' do
    let(:data) { {} }
    
    it 'returns empty array' do
      expect(get.teams_by_shamings).to eq []
    end
    
    it 'retuns empty array' do
      expect(get.users_by_shamings).to eq []
    end
  end

end
