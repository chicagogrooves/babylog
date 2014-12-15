Template.feeding.rendered = () => {
    if(!Session.get("feeding")){
        Session.set("feeding", Feedings.insert({time: new Date()}))
    }
}

Template.feeding.helpers({
    active: function (which) {return this[which] ? "active" : ""}
})

Template.feeding.events({
    "click #btn-end": (e, t) => {
        Feedings.update(t.data._id, {$set: {completed: true}})
        Session.set("feeding")
        Router.go("history")
    },
    "click .which": (e, t) => {
        let obj = {},
            which = e.target.attributes["data-which"].value

        obj[which] = true
        Feedings.update(t.data._id, {$set: obj})
    }
})
