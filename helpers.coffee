Feedings.helpers
    sides: ->
      (if @L then "L" else "") + (if @R then "R" else "")
    when: ->
      moment(@time).calendar()
    duration: ->
      unless @endTime
        "(in progress)"
      else
        m = Math.ceil(moment.duration(moment(@endTime).diff(moment(@time))).asMinutes())
        "#{m} minutes"
