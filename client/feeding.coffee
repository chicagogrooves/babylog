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
  showBottleParams: ->
    if @bottleAmount then "" else "hide"

Template.feeding.events
  "click #btn-end": (e) ->
    Feedings.update @._id, $set: {endTime: new Date, completed: true}
    Router.go "history"

  "click .which": (e) ->
    obj = {}
    which = e.target.attributes["data-which"].value
    obj[which] = true
    id = Feedings.insert(time: new Date)
    #FIXME preserve the old value as well
    Feedings.update id, $set: obj
    $(".btn-bottle").prop("disabled", true)
    timer.start()
    e.target.blur()

  "click .btn-bottle": (e) ->
    $(".which").prop("disabled", true)
    $(".bottle-params").show()
    id = Feedings.insert(time: new Date, bottleAmount: 2.5)

  "click .bottle-ctl": (e) ->
    amt = e.target.attributes["data-amount"].value
    Feedings.update @._id, $inc: {bottleAmount: Number(amt)}
