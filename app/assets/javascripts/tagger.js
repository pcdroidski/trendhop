(function($) {

	$.fn.addTrend = function(value, old, first) {

    // console.log(value)
    // console.log(old)

	  id = $(this).attr('id')

    tagget = $("<span>").addClass("tag").text(value);// .insertBefore('#' + id + '_addTag');

    if (first){
      text_holder = $("<span id='input_content_text'>");
      console.log("TEXT HOLDER")
    } else {
      text_holder = $(this).find('#input_content_text');
    }

    $(text_holder).append(old, tagget);

    test = $(this).append(text_holder);//.insertBefore("#"+id+'_addTag');
    console.log(test)
    return test;
  };

  $.fn.startTag = function(options) {
    var thesettings = jQuery.extend({
      minChars:0,
      placeholderColor:'#666666',
      defaultText: "Enter  your post here!",
      width: '300px',
      height: '250px',
      first: true
    },options);

  	this.each(function() {

    id = $(this).attr('id')

		data_input = jQuery.extend({
			pid:id,
			real_input: '#'+id,
      // holder: '#'+id+'_tagsinput',
			text_wrapper: '#'+id+'_text',
			fake_input: '#'+id+'_addTag'
		}, thesettings);

    // input_text_area = $(real_input)
    var first_run = true;

		var markup = '<div id="'+id+'_tagsinput" class="tagsinput"><div id="'+id+'_addTag">';

    // $(markup).insertAfter(this);

		$(data_input.real_input).keypress(function(e) {
		  if (e.which == 35) {
        // console.log(remove_stuff)
        test = $(data_input.real_input).remove("span");
        console.log(test)

        $(test).bind('keypress',data_input,function(event) {
					if (event.which==13 ) {
            console.log(test)
            tag_stuff = $(test).val().split("#");
            // console.log(tag_stuff)
            var real_array = $.makeArray(tag_stuff)
            // console.log(real_array)
            var trend_array = []
            var the_trend = real_array[real_array.length-1]
            old_text = real_array[real_array.length-2]
            the_trend = $.trim(the_trend)
            trend_array.push(the_trend);
            if (first_run) {
              $(data_input.real_input).addTrend(the_trend, old_text, first_run);
              first_run = false;
            }else {
              $(data_input.real_input).addTrend(the_trend, old_text, first_run);
              console.log(first_run)
            }

            // $.map(real_array, function(value, i){
            //     if (!value.indexOf("#")){
            //     console.log(value)
            //     trend_array.push(value);
            //   }
            // });
            // console.log($(data_input.fake_input).val())
            // console.log(trend_array)
            return false;
	      }

		  });
	  }
  });
  });
  return this;
};
})(jQuery);