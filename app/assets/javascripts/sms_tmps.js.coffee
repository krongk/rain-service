# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#sms_tmp_content").change ->
    $("#sms_tmp_content_size").val( 140 - parseInt($(".counter").text()) )