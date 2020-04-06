$(document).on 'turbolinks:load', ->
  $(".remove_team").on 'click', (e) =>
    $('#remove_team_modal').modal('open')
    $('.remove_team_form').attr('action', 'teams/' + e.target.id)
    return false

  $('.remove_team_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        contentType:'application/json',
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          $(location).attr('href','/');
        error: (jqXHR, textStatus, errorThrown) ->
          $('#remove_team_modal').modal('close')
          Materialize.toast('Problem to delete Team &nbsp;<b>:(</b>', 4000, 'red')
    return false