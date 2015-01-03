Router.configure
  layoutTemplate: "layout"

Router.route "history",
    path: "/"
    data: -> feedings: feedingsGoingBack

Router.route "feeding",
    path: "/feeding/new"
    data: -> currentFeeding().fetch()[0]

Router.route "feedingEdit",
    path: "/feeding/:_id/edit"
    data: -> Feedings.findOne(@params._id)
