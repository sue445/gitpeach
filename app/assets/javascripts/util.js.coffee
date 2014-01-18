window.util =
  alert: (message, alert_class="alert-success", is_auto_close=false) ->
    $("#alert-area .alert").alert('close')

    close_button =
      $("<a/>").
      addClass("close").
      attr(
        "data-dismiss": "alert"
        href: "#"
        "aria-hidden": true
      ).
      html("&times;")

    $("<div/>").
      addClass("alert").
      addClass(alert_class).
      text(message).
      append(close_button).
      appendTo($("#alert-area"))

    if is_auto_close
      window.setTimeout(
        ->
          $("#alert-area .alert").alert('close')
        2000
      )

$(document).ready ->
  $(document).ajaxError (event, jqxhr, settings, exception) ->
    if jqxhr.responseJSON
      json = jqxhr.responseJSON
      util.alert("#{json.exception} #{json.message}", "alert-danger", false)
    else
      util.alert(jqxhr.responseText, "alert-danger", false)
