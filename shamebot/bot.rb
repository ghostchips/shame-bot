module ShameBot
  class Bot < SlackRubyBot::Bot
    
    help do
      title 'Wall of Shame'
      desc  'Here are recorded those who have made mistakes'
      
      command 'add' do
        desc 'Add user to a team'
        long_desc 'type "add @user to ops (or devs)" to add a user to a team'
      end
      
      command 'shame' do
        desc 'Shame people for their mistakes'
        long_desc 'type "shame @user for reason" to add a shaming to an existing user'
      end
      
    end

  end
end