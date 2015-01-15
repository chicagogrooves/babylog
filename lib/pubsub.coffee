@Feedings = new Mongo.Collection("feedings")
@DaysAtATime = 7
@tzAdjust = 19

@currentFeeding = ->
  Feedings.find {completed: {$ne: true}},
    limit: 1
    sort: [["time", "desc"]]

Meteor.atServer ->
  Meteor.publish "feedings", (daysBack = DaysAtATime) ->
    howfar = moment(new Date)
      .startOf("day")
      .subtract
        days: daysBack-1
        hours: tzAdjust # needed for prod only, cuz - timezones?
      .toDate()

    Feedings.find
      # time:
      #   $gt: howfar
      users:
        $in:
          [@userId]
    , sort: [["time", "desc"]]

Meteor.atClient ->
  Meteor.subscribe "feedings"
