Template.history.helpers
  startResume: ->
    if Session.equals("feeding", undefined) then "Start" else "Resume"
