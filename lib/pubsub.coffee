@Feedings = new Mongo.Collection("feedings")
@DaysAtATime = 2
@tzAdjust = 19

@feedingsGoingBack = (daysBack = DaysAtATime) ->
  howfar = moment(new Date)
    .startOf("day")
    .subtract
      days: daysBack-1
      hours: tzAdjust # needed for prod only, cuz - timezones?
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
