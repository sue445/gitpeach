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
      drag_manager.drag_end(event, ui)
      null
  )

  $(".issue-column").droppable(
    scope: "issue-column-scope"
    tolerance: "fit"
  )
