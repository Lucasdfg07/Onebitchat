# Load messages getting the first channel
$(document).on 'turbolinks:load', ->
  if $('ul.channels li:first div a span').attr('id') != undefined
    window.open($('ul.channels li:first div a span').attr('id'), 'channels')

# Get channel messages when clicked
  $('body').on 'click', 'a.open_channel', (e) ->
    window.open(e.target.id, 'channels')