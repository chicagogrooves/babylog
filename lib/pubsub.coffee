@Feedings = new Mongo.Collection("feedings")

@feedingsGoingBack = ->
    Feedings.find {},
        sort: [["time", "desc"]]

@currentFeeding = ->
    Feedings.find {completed: {$ne: true}},
        limit: 1
        sort: [["time", "desc"]]

Meteor.atServer ->
    Meteor.publish "feedings", feedingsGoingBack

Meteor.atClient ->
    Meteor.subscribe "feedings"
