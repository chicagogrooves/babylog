@Feedings = new Mongo.Collection("feedings")
@DaysAtATime = 2

@feedingsGoingBack = (daysBack = DaysAtATime) ->
  howfar = moment(new Date)
    .startOf("day")
    .subtract
      days: daysBack-1
    .toDate()

  Feedings.find {time: {$gt: howfar}},
    sort: [["time", "desc"]]

@currentFeeding = ->
  Feedings.find {completed: {$ne: true}},
    limit: 1
    sort: [["time", "desc"]]

Meteor.atServer ->
  Meteor.publish "feedings", feedingsGoingBack

Meteor.atClient ->
  Meteor.subscribe "feedings"
