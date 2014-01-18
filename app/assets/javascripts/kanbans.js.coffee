# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
show_label_count = ->
  $.ajax(
    url: "/" + $("#kanban_name").val() + "/labels.json"
    success: (data, data_type) ->
      for i, label_group of data.label_groups
        label = label_group.label
        issues = label_group.issues
        $("#count_#{label.id}").text(issues.length)
  )

update_issue_labels = (issue) ->
  issue_panel_labels = $("#issue_#{issue.id} .issue-panel__labels")
  issue_panel_labels.empty()
  for i, label of issue.labels
    $("<span/>").addClass("label label-success").text(label).appendTo(issue_panel_labels)

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
      kanban_name = $("#kanban_name").val()
      $.ajax(
        url: "/#{kanban_name}/issues/#{issue_id}"
        data:
          to_label_id: to_label_id
        method: "PUT"
        success: (response, data_type) ->
          show_label_count()
          update_issue_labels(response.data)

        error: ->
          drag_manager.rollback()
      )
      null
  )
