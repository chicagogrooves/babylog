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

  calendarOptions: ->
    defaultView: "agendaWeek" #"agendaWeek"
    height: "600px"
    foo: "bar"
    header:
      left: ""
      center: ""
      right:  "today prev,next"
    events:
      Feedings.find().fetch().map (f) ->
        start: f.time
        end: f.endTime
        title: f.detail()
        id: f._id
    eventClick: (e) ->
      Router.go "feedingEdit", _id: e.id
      console.dir(e)

Template.history.events
  "click .btn-start": (e) ->
    Router.go "feeding"
