issue_id = null

init_issue_panel = (selector) ->
  $(selector).draggable(
    scope:  "label-column-scope"
    revert: "invalid"
    stack:  "issue-panel"
    cursor: "move"
    snap:   true
    handle: ".issue-panel__header"
    start: (event, ui) ->
      issue_id = event.target.id.replace("issue_", "")
      drag_manager.drag_start(event, ui)
      null
    stop: (event, ui) ->
      drag_manager.drag_end(event, ui)
      null
  )
  $("#{selector} .issue-panel__updated_at").tooltip()

init_label_column = (selector) ->
  $(selector).droppable(
    scope: "label-column-scope"
    tolerance: "fit"
    drop: (event, ui) ->
      to_label_id = event.target.id.replace("label_", "")
      kanban_name = $("#kanban_name").val()
      $.ajax(
        url: "/#{kanban_name}/issues/#{issue_id}"
        data:
          to_label_id: to_label_id
        method: "PUT"
        error: ->
          drag_manager.rollback()
      )
      null
  )

$(document).ready ->
  width_rate = 100 / $("#label_groups_count").val()
  $(".label-area").css("width", "#{width_rate}%")

  init_issue_panel(".issue-panel")
  init_label_column(".label-column")

  pusher  = new window.Pusher($("#pusher_key").val())
  channel = pusher.subscribe($("#channel").val())
  channel.bind(
    "issue_update_event",
    (data) ->
      for label_id, issue_ids of data.label_group_ids
        ((label_id, issue_ids) ->
          $("#count_#{label_id}").text(issue_ids.length)
          for issue_id in issue_ids
            ((issue_id) ->
              $.ajax(
                url: "/#{$("#kanban_name").val()}/issues/#{issue_id}"
                dataType: "html"
                success: (html, data_type) ->
                  $("#issue_#{issue_id}").remove()
                  $("#label_#{label_id}").append($(html))
                  init_issue_panel("#issue_#{issue_id}")
              )
            )(issue_id)
        )(label_id, issue_ids)
  )

  $("#create_issue_form").submit ->
    if $("#new_issue_title").val()
      $("#loading").show()
      $("#create_issue_button").attr("disabled", "disabled")
      $.ajax(
        url: "/#{$("#kanban_name").val()}/issues"
        method: "POST"
        dataType: "json"
        data:
          title: $("#new_issue_title").val()
        success: (data, data_type) ->
          $("#loading").hide()
          $("#create_issue_button").removeAttr("disabled")
          $("#new_issue_title").val("")
      )
    false
