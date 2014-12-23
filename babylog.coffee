@Feedings = new Mongo.Collection("feedings")

feedingsGoingBack = ->
    Feedings.find {},
        sort: [["time", "desc"]]

currentFeeding = ->
    Feedings.find {completed: {$ne: true}},
        limit: 1
        sort: [["time", "desc"]]

Meteor.atServer ->
    Meteor.publish "feedings", feedingsGoingBack

Meteor.atClient ->
    Meteor.subscribe("feedings")
    window.Feedings = Feedings

Meteor.startup ->
    @Session = @SessionAmplify

Router.route "history",
    path: "/"
    data: -> feeding: feedingsGoingBack

Router.route "feeding",
    path: "/feeding/new"
    data: -> currentFeeding().fetch()[0]
