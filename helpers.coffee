Feedings.helpers
  when: (fmt="calendar")->
    if fmt is "calendar"
      moment(@time).calendar()
    else
      moment(@time).format(fmt)
  detail: ->
    if @bottleAmount
      "#{@bottleAmount} oz"
    else
      (if @L then "L" else "") + (if @R then "R" else "")
  duration: ->
    unless @endTime
      "(in progress)"
    else
      [start, end] = [moment(@time), moment(@endTime)]
      m = Math.ceil moment.duration(end.diff(start)).asMinutes()
      "#{m} minutes"
