# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  jQuery("#pop-down").hide()
  $("#trend-now").click ->
    $("#pop-down").slideToggle("fast")
    false
  $("#cancel-trend").click ->
    $("#pop-down").slideToggle("fast")
    false
  $("#trend-blog").click ->
    $("#pop-down").slideToggle("fast")
    false


