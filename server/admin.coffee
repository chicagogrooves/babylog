Meteor.startup ->
  Houston.add_collection Meteor.users
  Houston.add_collection new Mongo.Collection "meteor_accounts_loginServiceConfiguration"
