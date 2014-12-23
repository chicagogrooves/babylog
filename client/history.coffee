Template.history.helpers
  startResume: ->
    if Session.equals("feeding", undefined) or Session.equals("feeding", null)
      "Start"
    else
      "Resume"
