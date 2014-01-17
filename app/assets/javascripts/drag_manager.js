// via. http://jsdo.it/tgaisho/draggable1

var drag_manager = (function(){
  // instance variables
  var target_id = null;

  // same to kanban.css.scss
  var issue_panel_default_z_index = 50;

  // public methods
  function drag_start(event, ui){
    target_id = event.target.id;

    var target = $("#" + target_id);
    $(".ui-draggable").css("z-index", issue_panel_default_z_index);
    target.css("z-index", 100);
  }

  function drag_end(event, ui){
    var target = $("#" + target_id);

    var draggables = $.grep($(".ui-draggable"), function(v, i){
      v = $(v);
      // reject own
      return (v.attr("id") && v.attr("id") !== target_id);
    });

    var is_conflict = is_conflict_position(
//        target.position(),
        target.get(0).getBoundingClientRect(),
        {width: target.width(), height: target.height()},
        draggables
    );

    if(is_conflict){
      target.css({
        left: ui.originalPosition.left,
        top:  ui.originalPosition.top
      });
      return false;
    }

    return true;
  }

  return {
    drag_start: drag_start,
    drag_end:   drag_end
  };

  // private methods
  function is_conflict_position(position, size, targets){
    var corner_positions = get_corner_positions(position.left, position.top, size.width, size.height);
    var conflict = false;

    $(targets).each(function(i, v){
//      var target_position = $(v).position();
      var target_position = $(v).get(0).getBoundingClientRect();
      var target_corner_positions = get_corner_positions(target_position.left, target_position.top, $(v).width(), $(v).height());

      $(corner_positions).each(function(j, o){
        if(o.left >= target_corner_positions[0].left - 15
            && o.left <= target_corner_positions[1].left + 15
            && o.top >= target_corner_positions[0].top - 15
            && o.top <= target_corner_positions[2].top + 15
            ){
          conflict = true;
        }
      });
    });

    return conflict;
  }

  function get_corner_positions(left, top, width, height){
    var obj = [];
    obj.push({left: left, top: top}); // left top
    obj.push({left: left + width, top: top}); // right top
    obj.push({left: left, top: top + height}); // left down
    obj.push({left: left + width, top: top + height}); // right down
    return obj;
  }

}());
