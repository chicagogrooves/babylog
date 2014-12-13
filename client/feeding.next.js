Template.feeding.rendered = () => {
    if(!Session.get("feeding")){
        Session.set("feeding", Feedings.insert({time: new Date()}))
    }
}
Template.feeding.events({
    "click #btn-end": (e, t) => {
        Feedings.update(t.data._id, {$set: {completed: true}})
        Session.set("feeding")
        Router.go("history")
    },
    "click .which": (e, t) => {
        let which = e.target.attributes["data-which"].value,
            obj = {}
        obj[which] = true

        Feedings.update(t.data._id, {$set: obj})
    }
})
