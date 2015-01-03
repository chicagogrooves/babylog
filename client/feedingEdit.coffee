Template.feedingEdit.helpers
  startAdjusterOptions: ->
    closest = moment(@time).startOf("hour")
    opts = []
    for h in [0..23]
      for m in [0, 15, 30, 45]
        t = moment({hours: h, minutes: m})
        opts.push
          text: t.format("h:mm a")
          value: "#{h}|#{m}"
    opts
  when: (fmt="calendar")->
    if fmt is "calendar"
      moment(@time).calendar()
    else
      moment(@time).format(fmt)

Template.feedingEdit.events
  "change .newStart": (e, t)->
    [h, m] = $(e.target).val().split("|")
    newTime = moment(t.data.time).startOf("day").add
      hours: h
      minutes: m
    Feedings.update t.data._id, $set: {time: newTime.toDate()}
