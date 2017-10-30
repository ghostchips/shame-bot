require 'spec_helper'

describe WallOfShame do
  
  subject { WallOfShame }
  
  it 'does something' do
    expect(subject.data).to eq({})
  end
  
  it 'teams' do
    expect(subject.teams).to eq('DEVS, OPS')
  end
  
end