require 'spec_helper'

describe WallOfShame do
  
  subject(:wos) { WallOfShame }
  
  before do
    yaml_parse = YAML.load_file("spec/wall_of_shame_spec.yaml")
    allow(YAML).to receive(:load_file).with(anything) { yaml_parse }
  end
    
  it '#teams' do
    expect(wos.teams).to eq('DEVS, OPS')
  end
  
  it '#users' do
    expect(wos.users).to eq("DEVS: Micah, Bono\nOPS: Sam")
  end
  
  it '#add_team' do
    expect(wos.add_team('NEW_TEAM')).to eq(true)
    expect(wos.class_variable_get(:@@data)).to include('NEW_TEAM'=>{})
  end
  
  it '#add_user' do
    expect(wos.add_user('Trevor','DEVS')).to eq(true)
    expect(wos.class_variable_get(:@@data)['DEVS']).to include('Trevor' => [] )
  end
  
  it '#list_shamings' do
    expect(wos.list_shamings('Micah')).to eq("Reason 1\nReason 2")
  end
  
  it '#count_user_shamings' do
    expect(wos.count_user_shamings('Micah')).to eq(2)
  end
  
end