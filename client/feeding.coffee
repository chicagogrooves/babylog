Template.feeding.rendered = ->
  if SessionAmplify.equals("feeding", undefined)
    SessionAmplify.set "feeding", Feedings.insert(time: new Date)

Template.feeding.helpers
  active: (which) ->
    if @[which] then "active" else ""
  currentFeedingId: ->
    JSON.stringify Feedings.findOne Session.get("feeding")

Template.feeding.events
  "click #btn-end": (e, t) ->
    Feedings.update t.data._id, $set: {completed: true}
    Session.set "feeding", undefined
    Router.go "history"

  "click .which": (e, t) ->
    obj = {}
    which = e.target.attributes["data-which"].value
    obj[which] = true
    Feedings.update t.data._id, $set: obj
    e.target.blur()
