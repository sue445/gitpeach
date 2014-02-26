# via. http://jsdo.it/tgaisho/draggable1

class DragManager
  # instance variables
  target_id = null
  original_ui = null

  # same to kanban.css.scss
  issue_panel_default_z_index = 50

  # public methods
  drag_start: (event, ui) =>
    target_id = event.target.id
    original_ui = ui

    target = $("#" + target_id)
    $(".ui-draggable").css("z-index", issue_panel_default_z_index)
    target.css("z-index", 100);

  drag_end: (event, ui) =>
    target = $("#" + target_id)

    draggables = $.grep($(".ui-draggable"), (v, i) ->
      v = $(v)
      # reject own
      return (v.attr("id") && v.attr("id") != target_id)
    )

    is_conflict = is_conflict_position.call(
      @,
      target.get(0).getBoundingClientRect(),
      {width: target.width(), height: target.height()},
      draggables
    )

    if(is_conflict)
      rollback()
      false
    else
      true

  rollback: =>
    target = $("#" + target_id)

    target.css(
      left: original_ui.originalPosition.left,
      top:  original_ui.originalPosition.top
    )

  # private methods
  is_conflict_position = (position, size, targets) =>
    corner_positions = get_corner_positions(position.left, position.top, size.width, size.height)
    conflict = false

    $(targets).each (i, v) ->
      target_position = $(v).get(0).getBoundingClientRect()
      target_corner_positions = get_corner_positions.call(@, target_position.left, target_position.top, $(v).width(), $(v).height())

      $(corner_positions).each ->
        (j, o) ->
          if o.left >= target_corner_positions[0].left - 15 &&
            o.left <= target_corner_positions[1].left + 15 &&
            o.top >= target_corner_positions[0].top - 15 &&
            o.top <= target_corner_positions[2].top + 15
              conflict = true

    conflict

  get_corner_positions = (left, top, width, height) =>
    obj = [];
    obj.push(left: left        , top: top) # left top
    obj.push(left: left + width, top: top) # right top
    obj.push(left: left        , top: top + height) # left down
    obj.push(left: left + width, top: top + height) # right down
    obj

window.drag_manager = new DragManager()
