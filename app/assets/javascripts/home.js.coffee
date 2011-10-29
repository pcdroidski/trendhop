# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  jQuery("#pop-down").hide()

  button_L = 0
  button_R = 10

  $("#menu ul a").live "click" , ->
    $.getScript(this.href)
    return false

  $(document).ready ->
    $("#menuNav-left").hide()

    $("#menuNav-right").click ->
      $(".trends-list-container").animate
        right: "+=" + '312px'
        200
      button_L = button_L + 1
      button_R = button_R - 1
      $("#menuNav-left").show()
      if button_R < 4
        $("#menuNav-right").hide()
      else
        $("#menuNav-right").show()
      return

    $("#menuNav-left").click ->
      $(".trends-list-container").animate
        right: "-=" + '312px'
        200
      button_L = button_L - 1
      button_R = button_R + 1
      if button_L > 0
        $("#menuNav-left").show()
      else
        $("#menuNav-left").hide()
      $("#menuNav-right").show()
      return

  # Article trend button
  $("#trend-article-button").click ->
    $("#main-home-background").toggleClass("darken-background")
    $("#drop-down-button").toggleClass("open-menu")
    $(".profile-menu").toggleClass("plus-menu")
    $("#trend-something").show()
    $("#current-now-button").addClass("inactive")
    $("#trend-now-button").addClass("active")
    $("#current-now").hide()
    $("#pop-down").slideToggle("fast")
    false

  $("#tags").tagsInput();

  # MAin drop down
  $("#drop-down-button").click ->
    $("#main-home-background").toggleClass("darken-background")
    $("#drop-down-button").toggleClass("open-menu")
    $(".profile-menu").toggleClass("plus-menu")
    $("#current-now").show()
    $("#current-now-button").addClass("active")
    $("#trend-now-button").addClass("inactive")
    $("#trend-something").hide()
    $("#pop-down").slideToggle("fast")
    false

  $("#current-now-button").click ->
    $("#trend-something").hide()
    $("#current-now").show()
    $("#current-now-button").removeClass("inactive").addClass("active")
    $("#trend-now-button").removeClass("active").addClass("inactive")
    return

  $("#trend-now-button").click ->
    $("#current-now").hide()
    $("#trend-something").show()
    $("#current-now-button").removeClass("active").addClass("inactive")
    $("#trend-now-button").removeClass("inactive").addClass("active")
    $("#input_content").startTag()
    return

  $("#cancel-trend").click ->
    $("#main-home-background").toggleClass("darken-background")
    $("#drop-down-button").toggleClass("open-menu")
    $("#pop-down").slideToggle("fast")
    false
  # $("#trend-blog").click ->
  #   $("#pop-down").slideToggle("fast")
  #   false


    # $("#pop-down").hide()
    #
    # $("drop-down-button").click ->
    #   $("#pop-down").slideDown("fast")
    #   # $("#current-now").show()
    #   # $("#trend-something").hide()
    #   false
      # $("#trend-now-button").click ->
      #      $("#trend-something").hide()
      #      $("#current-now").show()
      #      $("#cancel-trend").click ->
      #        $("#pop-down").slideUp("fast")
      #        false
      #      return
      #    $("current-now-button").click ->
      #      $("#current-now").show()
      #      $("#trend-something").hide()
      #      false
      #    return



    # $("#trend-blog").click ->
    #   $("#pop-down").slideToggle("fast")
    #   false
    #   $("#current-now").hide()
    #   $("#trend-something").show()


