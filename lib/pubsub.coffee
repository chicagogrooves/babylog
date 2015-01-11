@Feedings = new Mongo.Collection("feedings")
@DaysAtATime = 2
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

    console.log "User", @userId, (@userId is "hiLiSR9W64Di2gd7")
    userId = @userId #"hiLiSR9W64Di2gd7P" #@userId
    Feedings.find({time: {$gt: howfar}, users: {$in: [userId]}})

Meteor.atClient ->
  Meteor.subscribe "feedings"
