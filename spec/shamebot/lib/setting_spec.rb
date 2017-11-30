require 'spec_helper'

describe ShameBot::Lib::Setting do

  let(:existing_user) { 'Micah' }
  let(:new_user)      { 'Trevor' }
  let(:existing_team) { 'DEVS' }
  let(:new_team)      { 'DIUS' }
  let(:reasons)       { ['Reason 1', 'Reason 2'] }
  let(:data) do
    { 'DEVS' => { "Micah" => ["Reason 1", "Reason 2"], "Bono"=> ["Reason 1"] },
      'OPS'  => { "Sam" => ["Reason 1", "Reason 2"] } }
  end  

  let(:no_team_error) { "#{new_team} is not listed as a team" }
  let(:no_user_error) { "#{new_user} is not listed as a user" }

  subject(:set) { ShameBot::Lib::Setting.new }

  before(:each) do 
    allow(YAML).to receive(:load_file).with(anything) { data }
    allow(File).to receive(:open).with("wall_of_shame.yaml", "w") { puts 'writing to yaml...'; true }
  end
  
  after(:each)  { SpecHelper.reset_data }

  context 'Shaming' do

    it 'shame an existing user' do
      expect(set.shame(existing_user, reasons.first)).to eq "Micah shamed for Reason 1."
      expect(set.shame(existing_user, *reasons)).to eq "Micah shamed for Reason 1; Reason 2."
    end

    it 'shame new user' do
      expect(set.shame(new_user, reasons)).to eq no_user_error
    end

  end

  context 'Setting users and teams' do

    context 'adding' do
      
      it 'a new user to an existing team' do
        expect(set.add_user(new_user, existing_team)).to eq "#{new_user} added to #{existing_team} team"
      end

      it 'user to new team' do
        expect(set.add_user(existing_user, new_team)).to eq no_team_error
        expect(set.add_user(new_user, new_team)).to eq no_team_error
      end

      it 'existing user to existing team' do
        expect(set.add_user(existing_user, existing_team)).to eq "#{existing_user} is already listed in #{existing_team}"
      end

      it 'new team' do
        expect(set.add_team(new_team)).to eq "#{new_team} added as a team"
      end

      it 'existing team' do
        expect(set.add_team(existing_team)).to eq "#{existing_team} is already listed as a team"
      end
    end

    context 'removing' do
      
      it 'existing user' do
        expect(set.remove_user(existing_user)).to eq "#{existing_user} removed from DEVS team"
      end

      it 'new user' do
        expect(set.remove_user(new_user)).to eq no_user_error
      end

      it 'existing team' do
        expect(set.remove_team(existing_team)).to eq "#{existing_team} team removed from Wall of Shame"
      end

      it 'new team' do
        expect(set.remove_team(new_team)).to eq no_team_error
      end

    end
  end
end
