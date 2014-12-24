Template.history.helpers
  startResume: ->
    currentFeeding = ->
        Feedings.find {completed: {$ne: true}},
            limit: 1
            sort: [["time", "desc"]]

    if currentFeeding().count() is 0
      "Start"
    else
      "Resume"

Template.history.events
  "click .deleteButton": (e, t) ->
    if confirm("Delete this feeding?")
      Feedings.remove(@._id)
