require 'spec_helper'

describe ShameBot::Bot do
  
  subject(:app) { ShameBot::Bot.instance }
  
  it_behaves_like 'a slack ruby bot'
end