# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".issue-panel").draggable(
    scope:  "label-issues"
    revert: "invalid"
    stack:  "issue-panel"
    cursor: "move"
    snap:   true
    stop: ->
      console.log "stop"
  )

  $(".label-issues").droppable(
    activeClass: "grep"
    scope: "label-issues"
    tolerance: "fit"
  )
