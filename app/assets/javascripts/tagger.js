(function($) {

  $.fn.startTag = function(options) {
    var settings = jQuery.extend({
      minChars:0,
      placeholderColor:'#666666'
    },options);

    id = $(this).attr('id')

		data = jQuery.extend({
			pid:id,
			real_input: '#'+id,
			holder: '#'+id+'_tagsinput',
			input_wrapper: '#'+id+'_addTag',
			fake_input: '#'+id+'_tag'
		}, settings);

		$(data.real_input).keypress(function(e) {
		  if (e.which == 35) {

		    console.log($(data.real_input).val())
		  }

		});

    // if ($(event.data.fake_input).val()!='' && $(event.data.fake_input).val()!=d) {

    //     $(data.fake_input).bind('keypress',data,function(event) {
    //  if (event.which==event.data.delimiter.charCodeAt(0) || event.which==13 ) {
    //    if( (event.data.minChars <= $(event.data.fake_input).val().length) && (!event.data.maxChars || (event.data.maxChars >= $(event.data.fake_input).val().length)) )
    //      $(event.data.real_input).addTag($(event.data.fake_input).val(),{focus:true,unique:(settings.unique)});
    //                                        console.log($(event.data.real_input).val())
    //
    //    return false;
    //  }
    // });



  }

})(jQuery);