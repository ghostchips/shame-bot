require 'spec_helper'

describe WallOfShame do
  
  let(:data) do
    { 'DEVS' => { "Micah" => ["Reason 1", "Reason 2"], "Bono"=> ["Reason 1"] },
      'OPS'  => { "Sam" => ["Reason 1", "Reason 2"] } }
  end  
  
  subject(:wos) { WallOfShame }

  before(:each) do 
    allow(YAML).to receive(:load_file).with(anything) { data } 
    allow(File).to receive(:open).with("wall_of_shame.yaml", "w") { puts 'writing to yaml...'; true }
  end
  
  after(:each)  { SpecHelper.reset_data }
  
  context 'User methods' do
    it '#users' do
      expect(wos.users).to eq(%w[Micah Bono Sam])
    end

    it '#add_user' do
      expect(wos.add_user('Trevor','DEVS')).to eq(true)
      expect(wos.class_variable_get(:@@data)['DEVS']).to include('Trevor' => [] )
    end

    it '#add_user with empty data' do
      data = {}
      expect(wos.add_user('Trevor','DEVS')).to eq(true)
      expect(wos.class_variable_get(:@@data)['DEVS']).to include('Trevor' => [] )
    end

    it '#add_user updates yaml' do
      expect(wos).to receive(:update_yaml)
      wos.add_user('Trevor','DEVS')
    end

    it '#add_user with user in another team' do
      expect(wos.add_user('Sam','DEVS')).to eq(false)
    end

    it '#add_user with invalid team' do
      expect(wos.add_user('Trevor','DIUS')).to eq(false)
    end

    it '#add_user with existing user' do
      expect(wos.add_user('Bono','DEVS')).to eq(false)
    end

    it '#user_data' do
      expect(wos.user_data('Micah')).to eq(data['DEVS']['Micah'])
    end

    it '#user_data with invalid user' do
      expect(wos.user_data('Harry')).to eq(false)
    end

    it '#user_team' do
      expect(wos.user_team('Micah')).to eq("DEVS")
    end

    it '#shame' do
      expect(wos.shame('Micah', 'Introducing bug', 'Not telling anyone')).to eq(true)
      expect(wos.user_data('Micah')).to include('Introducing bug', 'Not telling anyone')
    end

    it '#shame updates yaml' do
      expect(wos).to receive(:update_yaml)
      wos.shame('Micah', 'Introducing bug')
    end

    it '#remove_user' do
      expect(wos.remove_user('Bono')).to eq(true)
      expect(wos.class_variable_get(:@@data)['DEVS']).to_not include({'Bono'=>['Reason 1']})
    end

    it '#remove_user updates yaml' do
      expect(wos).to receive(:update_yaml)
      wos.remove_user('Bono')
    end
  end

  context 'Team methods ' do
    it '#teams' do
      expect(wos.teams).to eq(['DEVS', 'OPS'])
    end

    it '#add_team' do
      expect(wos.add_team('TESTING')).to eq(true)
      expect(wos.class_variable_get(:@@data)).to include('TESTING'=>{})
    end

    it '#add_team with empty data' do
      data = {}
      expect(wos.add_team('TESTING')).to eq(true)
      expect(wos.class_variable_get(:@@data)).to include('TESTING'=>{})
    end

    it '#add_team updates yaml' do
      expect(wos).to receive(:update_yaml)
      wos.add_team('TESTING')
    end

    it '#add_team with invalid team' do
      expect(wos.add_team('DEVS')).to eq(false)
    end

    it '#team_data' do
      expect(wos.team_data('DEVS')).to eq(data['DEVS'])
    end

    it '#team_data with invalid team' do
      expect(wos.team_data('DIUS')).to eq(false)
    end

    it '#remove_team' do
      expect(wos.remove_team('OPS')).to eq(true)
      expect(wos.class_variable_get(:@@data)).to_not include('OPS'=>{'Sam'=>['Reason 1']})
    end

    it '#remove_team updates yaml' do
      expect(wos).to receive(:update_yaml)
      wos.remove_team('OPS')
    end

  end
end
