# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  issue_id = null

  $(".issue-panel").draggable(
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

  $(".label-column").droppable(
    scope: "label-column-scope"
    tolerance: "fit"
    drop: (event, ui) ->
      to_label_id = event.target.id.replace("label_", "")
      $.ajax(
        url: "/" + $("#kanban_name").val() + "/issues/" + issue_id
        data:
          to_label_id: to_label_id
        method: "PUT"
        success: (data, data_type) ->
          util.alert("success")
          # TODO update using ajax
          location.href = "/" + $("#kanban_name").val()
        error: ->
          drag_manager.rollback()
      )
      null
  )
