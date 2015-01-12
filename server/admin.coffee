Meteor.startup ->
  Houston.add_collection Meteor.users
  Houston.add_collection "meteor_accounts_loginServiceConfiguration"
