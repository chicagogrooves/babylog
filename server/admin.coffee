Meteor.startup ->
  ServiceConfiguration.configurations.update
    service: "google"
  ,
    $set:
      loginStyle: "redirect"
