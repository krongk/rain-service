# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#myform1").submit ->
    $.ajax({
      type: "POST",
      url: "http://www.yufuwu.org:3000/common/pcall.js?callback=?",
      data: { product: { name: "Filip", description: "whatever" } },
      success:(data) ->
        alert data.id
        return false
      error:(data) ->
        return false
    })
    return false
