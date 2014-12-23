Template.feeding.rendered = ->
  if Session.equals("feeding", undefined) or Session.equals("feeding", null)
    Session.set "feeding", Feedings.insert(time: new Date)

Template.feeding.helpers
  active: (which) ->
    if @[which] then "active" else ""
  currentFeeding: ->
    JSON.stringify Feedings.findOne Session.get "feeding"

Template.feeding.events
  "click #btn-end": (e, t) ->
    Feedings.update t.data._id, $set: {endTime: new Date, completed: true}
    Session.set "feeding", null
    Router.go "history"

  "click .which": (e, t) ->
    obj = {}
    which = e.target.attributes["data-which"].value
    obj[which] = true
    Feedings.update t.data._id, $set: obj
    e.target.blur()
