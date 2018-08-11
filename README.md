
## Wall of Shame-Bot

For a bit of fun, our office had a Wall of Shame to keep track of each departments blunders. Initially this was posted on a sheet of paper on the wall, but was later set up through a simple Slack bot on a private slack channel.

However the Wall of Shame was accidentally deleted (_and not version controlled_) and is now gone forever. This is a simple attempt to rebuild it, with some added functionality.

In addition to being able to shame people, the bot can keep track of teams and it's members, list rankings, add or remove teams and team members. It also has some simple validations and persists the data into a yaml file.

> _Disclaimer: It was not my idea to have a wall of shame in the office. This was an existing practice and meant for some light-hearted banter between development and operations. I rebuilt it as a side project and was never actually reintroduced back into the office._

### How to use


First of all be sure to read how to set up a slack-bot on your slack channel. The ruby-slack-bot repo has a simple deployment guide to do this. You can find it [here](https://github.com/slack-ruby/slack-ruby-bot/blob/master/DEPLOYMENT.md).

After you've cloned the repo create an .env file and add your slack api token under in a SLACK_API_TOKEN constant.

Once you have created and invited your bot to your slack channel, run 'bunlde exec foreman start' to start your bot server. You then should be able to interact with your bot by typing out its @name followed by a command.

###### Commands

Type _help_ to see all available commands:

- **add team**: Add a team to the Wall of Shame
- **remove team**: Remove a team from the Wall of Shame
- **add user**: Add user to a team
- **remove user**: Remove user from a team
- **shame**: Shame people for their embarrasing blunders
- **list team shamings**: List all shamings from a team
- **list user shamings**: List a users shamings
- **list team rankings**: Display all teams ranked by their shamings count
- **list user rankings**: Display all users ranked by their shamings count

Subsequently type _help_ <_command_> to get more details.

___

#### To do:

- Be able to use @username handles when adding and shaming
- Add bot listener so you don't need @botname
- Persist the yaml file to a google drive sheet
