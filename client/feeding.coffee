timer = undefined

Template.feeding.created = ->
  timer = new ReactiveTimer(1)

Template.feeding.destroyed = ->
  timer.stop()
  timer = undefined

Template.feeding.helpers
  active: (which) ->
    if @[which] then "active" else ""
  currentFeeding: ->
    JSON.stringify(@)
  elapsed: ->
    if @time
      timer.tick() # makes it reactive
      moment(new Date - @time).format "mm:ss"

Template.feeding.events
  "click #btn-end": (e, t) ->
    Feedings.update t.data._id, $set: {endTime: new Date, completed: true}
    Router.go "history"

  "click .which": (e, t) ->
    obj = {}
    which = e.target.attributes["data-which"].value
    obj[which] = true
    id = Feedings.insert(time: new Date)
    Feedings.update id, $set: obj
    timer.start()
    e.target.blur()
