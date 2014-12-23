Template.history.helpers
  startResume: ->
    if Session.equals("feeding", undefined) or Session.equals("feeding", null)
      "Start"
    else
      "Resume"

Template.history.events
  "click .deleteButton": (e, t) ->
    if confirm("Delete this feeding?")
      Feedings.remove(@._id)
