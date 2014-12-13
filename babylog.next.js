var Feedings = new Mongo.Collection("feedings")
Feedings.helpers({
    sides: function () {return (this.L ? "L" : "")+(this.R ? "R" : "")},
    when: function () {return moment(this.time).calendar()}
})

var feedingsGoingBack = () =>
    Feedings.find(
        {}, {sort: [["time", "desc"]]})

var currentFeeding = () =>
    Feedings.find(
        {completed: {$ne: true}},
        {limit: 1, sort: [["time", "desc"]]})

Meteor.atServer(() => {
    Meteor.publish("feedings", feedingsGoingBack)
})

Meteor.atClient(() => {
    Meteor.subscribe("feedings")
    window.Feedings = Feedings
})


Router.route("history", {
    data: () => ({feeding: feedingsGoingBack})
})
Router.route("feeding", {
    path: "/feeding/new",
    data: () => currentFeeding().fetch()[0]
})
