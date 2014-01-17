# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".issue-panel").draggable(
    scope:  "issue-column-scope"
    revert: "invalid"
    stack:  "issue-panel"
    cursor: "move"
    snap:   true
    handle: ".issue-panel__header"
    start: (event, ui) ->
      drag_manager.drag_start(event, ui)
      null
    stop: (event, ui) ->
      is_moved = drag_manager.drag_end(event, ui)
      if is_moved
        issue_id = event.target.id.replace("issue_", "")
        $.ajax(
          url: "/" + $("#kanban_name").val() + "/issues/" + issue_id
          method: "PUT"
          success: (data, data_type) ->
            alert("success")
          error: ->
            alert("error")
        )
      null
  )

  $(".issue-column").droppable(
    scope: "issue-column-scope"
    tolerance: "fit"
  )
