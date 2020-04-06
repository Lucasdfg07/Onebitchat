$(document).on 'turbolinks:load', ->
  $(".add_user").on 'click', (e) =>
    $('#add_user_modal').modal('open')
    $('#team_user_team_id').val(e.target.id)
    return false

  $('.add_user_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {
          team_user: {
            email: $('#team_user_email').val()
            team_id: $('#team_user_team_id').val()
          }
        }
        success: (data, text, jqXHR) ->
          window.add(data['user']['name'], data['user']['id'], 'user')
          Materialize.toast('Success in add User &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem in add User &nbsp;<b>:(</b>', 4000, 'red')


    $('#add_user_modal').modal('close')
    return false