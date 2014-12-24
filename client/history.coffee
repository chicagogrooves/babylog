currentFeeding = ->
  Feedings.find {completed: {$ne: true}},
    limit: 1
    sort: [["time", "desc"]]

Template.history.helpers
  startResume: ->
    if currentFeeding().count() is 0
      "Start"
    else
      "Resume"

Template.history.events

  "click .deleteButton": (e, t) ->
    if confirm("Delete this feeding?")
      Feedings.remove(@._id)

  "click tr:nth-child(1)": (e, t) ->
    if currentFeeding().count() > 0
      Router.go "feeding"
