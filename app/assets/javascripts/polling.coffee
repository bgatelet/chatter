window.Poller = {
  poll: (timeout) ->
    if timeout is 0
      Poller.request()
    else
      this.pollTimeout = setTimeout ->
        Poller.request()
      , timeout || 5000
    clear: -> clear.Timeout(this.pollTimeout)
    request: ->
      first_id = $('.comment').first().date('id')
      $.get('/comments', after_id: first_id)
}


jQuery ->
  Poller.poll() if $('#comments').size() > 0
