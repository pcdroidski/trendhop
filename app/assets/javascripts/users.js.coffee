# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


# Test

jQuery ->
  $("#user_friend_group_id").change ->
    $(".edit_user_friend").serialize()
    $(".edit_user_friend").submit()
    return
  return

# end Test
