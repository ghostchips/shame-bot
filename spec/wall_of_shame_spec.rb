require 'spec_helper'

describe WallOfShame do
  
  subject(:wos) { WallOfShame }
  
  before do
    yaml_parse = YAML.load_file("spec/wall_of_shame_spec.yaml")
    allow(YAML).to receive(:load_file).with(anything) { yaml_parse }
  end
  
  context 'User methods ' do
    it '#users' do
      expect(wos.users).to eq(%w[Micah Bono Sam])
    end
    
    it '#add_user' do
      expect(wos.add_user('Trevor','DEVS')).to eq(true)
      expect(wos.class_variable_get(:@@data)['DEVS']).to include('Trevor' => [] )
    end
    
    it '#add_user invalid team' do
      expect(wos.add_user('Trevor','DIUS')).to eq(false)
      expect(wos.errors).to include('DIUS not listed as team')
    end
    
    it '#add_user existing user' do
      expect(wos.add_user('Bono','DEVS')).to eq(false)
      expect(wos.errors).to include('Bono already listed under DEVS')
    end
    
    it '#fetch_user_data' do
      expect(wos.fetch_user_data('Micah')).to eq(wos.send(:data)['DEVS']['Micah'])    
    end
    
    it '#fetch_user_data invalid user' do
      expect(wos.fetch_user_data('Harry')).to eq(false)
      expect(wos.errors).to include('Harry not listed as user')    
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
    
    it '#add_team invalid team' do
      expect(wos.add_team('DEVS')).to eq(false)
      expect(wos.errors).to include('DEVS already listed as team')    
    end    
    
    it '#fetch_team_data' do
      expect(wos.fetch_team_data('DEVS')).to eq(wos.send(:data)['DEVS'])
    end
    
    it '#fetch_team_data invalid team' do
      expect(wos.fetch_team_data('DIUS')).to eq(false)
      expect(wos.errors).to include('DIUS not listed as team')    
    end
  end
  
end