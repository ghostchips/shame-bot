module ShameBot
  class Bot < SlackRubyBot::Bot

    help do
      title 'Wall of Shame'
      desc  'Here are recorded those who have made embarassing blunders'

      command 'add team' do
        desc 'Add a team to the Wall of Shame'
        long_desc 'type "add team "TEAM NAME"" to add a team to the Wall of Shame'
      end

      command 'remove team' do
        desc 'Remove a team from the Wall of Shame'
        long_desc 'type "remove team "TEAM NAME"" to remove a team from the Wall of Shame'
      end

      command 'add user' do
        desc 'Add user to a team'
        long_desc 'type "add user \'USER NAME\' to \'TEAM NAME\' to add a user to a team'
      end

      command 'remove user' do
        desc 'Remove user from a team'
        long_desc 'type "remove user \'USER NAME"" to remove from their respective team'
      end

      command 'shame' do
        desc 'Shame people for their embarrasing blunders'
        long_desc 'type "shame \'USER NAME\' for reason" to shame to an existing user. Punctuate to beween reasons to add multiple at one time. Shamings cannot be deleted!'
      end

      command 'list team shamings' do
        desc 'List all shamings from a team'
        long_desc 'type "list team shamings for \'USER NAME\' to see a list for a teams collective shamings'
      end

      command 'list user shamings' do
        desc 'List a users shamings'
        long_desc 'type "list user shamings for \'USER NAME\' to see a users shamings'
      end

      command 'list team rankings' do
        desc 'Display all teams ranked by their shamings count'
        long_desc 'type "list team rankings" to see a list of all teams sorted by their shaming count'
      end

      command 'list user rankings' do
        desc 'Display all users ranked by their shamings count'
        long_desc 'type "list user rankings" to see a list of all users sorted by their shaming count'
      end
    end

  end
end
