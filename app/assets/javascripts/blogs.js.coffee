# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->

  $('#date-selector').DatePicker
    flat: true,	format: 'Y-m-d', current: '2011-11-01', calendars: 1, mode: 'range',	starts: 1, date: ['2008-07-28','2008-07-31'], onChange: (formatted, dates) ->
      $('#date_select').val(formatted)
      return

  return