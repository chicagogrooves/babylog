currentFeeding = ->
  Feedings.find {completed: {$ne: true}},
    limit: 1
    sort: [["time", "desc"]]

timer = new ReactiveTimer(10) # update the labels so Today/Yesterday

Template.history.helpers
  startResume: ->
    if currentFeeding().count() is 0
      "Start"
    else
      "Resume"
  when: ->
    timer.tick()
    moment(@time).calendar()


Template.history.events

  "click tr:first-child": (e) ->
    if currentFeeding().count() > 0
      Router.go "feeding"
