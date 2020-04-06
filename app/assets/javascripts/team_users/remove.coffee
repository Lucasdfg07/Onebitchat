$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.remove_user', (e) ->
    $('#remove_user_modal').modal('open')
    $('.remove_user_form').attr('action', 'team_users/' + e.target.id)
    $('#user_remove_id').val(e.target.id)
    return false

  $('.remove_user_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        dataType: 'json',
        data: {team_id: $(".team_id").val()}
        success: (data, text, jqXHR) ->
          $('.user_' + $('#user_remove_id').val()).remove()
          Materialize.toast('Success in remove User &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem to remove User &nbsp;<b>:(</b>', 4000, 'red')

    $('#remove_user_modal').modal('close')
    return false