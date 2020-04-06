# Get talk messages when clicked
$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.open_user', (e) ->
    window.open(e.target.id, 'talks')