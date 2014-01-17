window.util =
  alert: (message, alert_class="alert-success") ->
    $(".alert").alert('close')

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

$(document).ready ->
  $(document).ajaxError (event, jqxhr, settings, exception) ->
    if jqxhr.responseJSON
      json = jqxhr.responseJSON
      util.alert(json.exception + " " + json.message, "alert-danger")
    else
      util.alert(jqxhr.responseText, "alert-danger")
