@Feedings = new Mongo.Collection("feedings")
Feedings.helpers
    sides: -> (if @L then "L" else "")+(@R ? "R" : "")
    when: -> moment(@time).calendar()

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

Router.route "history",
    data: -> feeding: feedingsGoingBack

Router.route "feeding",
    path: "/feeding/new"
    data: -> currentFeeding().fetch()[0]
