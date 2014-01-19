refresh_table = ->
  $("tr.edit_label").each ->
    is_backlog = $(this).find("input[name='is_backlog_issue']").is(':checked')
    is_close   = $(this).find("input[name='is_close_issue']").is(':checked')

    if is_backlog || is_close
      # disabled
      $(this).find("input[name='gitlab_label']").attr('disabled','disabled')
    else
      # enabled
      $(this).find("input[name='gitlab_label']").removeAttr('disabled')

$(document).ready ->
  $(".header-tooltip").tooltip()
  refresh_table()

  $("tr.edit_label input:radio").change ->
    refresh_table()
