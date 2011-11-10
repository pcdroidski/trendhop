
(function($) {

	var delimiter = new Array();
	var tags_callbacks = new Array();
	var inputTrendText = "";
	var trend_number = 0;
	var tagslist = new Array();

	$.fn.quickAdd = function(value) {
	  this.each(function() {
			value = jQuery.trim(value);
			if (value != ""){
       $("#trends_container").append(
          $('<span>').addClass('tag').attr('id','tag_'+(trend_number+"")).append(
                $('<span>').text(value).append('&nbsp;&nbsp;'),
                $('<a>', {
                    href  : '#',
                    title : 'Removing tag',
                    id: trend_number+"",
                    text  : 'x'
                }).click(function () {
                    set_num = trend_number;
                    return $('#' + id).removeTag(escape(value), this);
                })
            ));
        trend_number = trend_number +1;
				tagslist.push(value);

        $.fn.trendsInput.updateTagsField(this,tagslist,null);
	    }
	  })

	};

	$.fn.addTag = function(value,text) {
				id = $(this).attr('id');
				text = text + value + " ";
				value = jQuery.trim(value);
				skipTag = false;
				if (value !='') {
	          $('#trend_input_content').append(
	            $('<a contenteditable="false" data-is-processed="1" style="margin: 0 1px 0 1px; width: auto; background: green; color: white; padding: 0 2px 0 2px;" class="tag">').attr('id', 'tag_'+(trend_number+"")).text(value),
	            $("</a>")
            );

           $("#trends_container").append(
              $('<span>').addClass('tag').attr('id','tag_'+(trend_number+"")).append(
                    $('<span>').text(value).append('&nbsp;&nbsp;'),
                    $('<a>', {
                        href  : '#',
                        title : 'Removing tag',
                        id: trend_number+"",
                        text  : 'x'
                    }).click(function () {
                        set_num = trend_number;
                        return $('#' + id).removeTag(escape(value), this);
                    })
                ));

					tagslist.push(value);
					trend_number = trend_number + 1;

					console.log(tagslist)
				  console.log($("#trend_input_content").text())

				}
        $.fn.trendsInput.updateTagsField(data.real_input,tagslist,inputTrendText);

			return false;
		};

	$.fn.removeTag = function(value, num) {
			value = unescape(value);
			this.each(function() {
				id = $(this).attr('id');
				tag_num = $(num).attr("id");

        // div = $("#"+id +"_tagsinput span").find("#tag_"+tag_num);
				var old = $(this).val().split(delimiter[id]);

        $('#trend_input_content '+"#tag_"+tag_num).remove();
        $("#trends_container " +"#tag_"+tag_num).remove();
				str = '';
				for (i=0; i< old.length; i++) {
					if (old[i]!=value) {
						str = str + delimiter[id] +old[i];
					}
				}
				        console.log(tagslist)
				num = $(num).attr("id");
				num = parseInt(num);
        tagslist[num] = "";

        ctext = $("#trend_input_content").text();

        $.fn.trendsInput.updateTagsField(data.real_input,tagslist,ctext);
        $("#trends_form").val(tagslist)

			});

			return false;
		};

	$.fn.tagExist = function(val) {
		if (jQuery.inArray(val, $(this)) == -1) {
		  return false; /* Cannot find value in array */
		} else {
		  return true; /* Value found */
		}
	};

	// clear all existing tags and import new ones from a string
	$.fn.importTags = function(str) {
		$('#'+id+'_tagsinput .tag').remove();
		$.fn.trendsInput.importTags(this,str);
	}

	$.fn.trendsInput = function(options) {
    var settings = jQuery.extend({
      interactive:true,
      defaultText:"What's #trending?",
      minChars:0,
      width:'95%',
      height:'80px',
      autocomplete: {selectFirst: false },
      'hide':true,
      'delimiter':',',
      'unique':true,
      removeWithBackspace:true,
      placeholderColor:'#666666'
    },options);

		this.each(function() {
			if (settings.hide) {
				$(this).hide();
			}
			id = $(this).attr('id')
			data = jQuery.extend({
				pid:id,
				real_input: '#'+id,
				holder: '#'+id+'_content',
				input_wrapper: '#'+id+'_addTag'
			},settings);

			delimiter[id] = data.delimiter;

			if (settings.onAddTag || settings.onRemoveTag || settings.onChange) {
				tags_callbacks[id] = new Array();
				tags_callbacks[id]['onAddTag'] = settings.onAddTag;
				tags_callbacks[id]['onRemoveTag'] = settings.onRemoveTag;
				tags_callbacks[id]['onChange'] = settings.onChange;
			}

			var markup = '<div contenteditable="true" id="trend_input_content">';
			markup = markup + '</div><div class="tags_clear"></div>';

			$(markup).insertAfter(this);

		  // TEST TES TEST!!! when user types "#"- start the tagging process
		  $("#trend_input_content").keypress(function(event) {
			  if (event.which==35 ) {
          var trending = '<input id="add_tag" style="font-size:15px; color: white; font-weight:bold; background: green;" >';
          $('#trend_input_content').append(trending);
          $("#add_tag").focus();
          $('#add_tag').keypress(function(event) {

            if (event.which==13|| event.which==44){
               input_stuff = $("#trend_input_content").text();
               input_trend = $("#add_tag").val();
               // console.log("text", input_stuff)
               // console.log("trend",input_trend)
               $.fn.addTag(input_trend, input_stuff);
               atext = $("#trend_input_content").text();
               test = atext.toString();
               pos = test.length
               $("#add_tag").blur().remove();
               $("#trend_input_content").focus();
               elem = document.getElementById("trend_input_content");
               setEndOfContenteditable(elem);
               $("#trend_input_content").append('&nbsp;');

               return false;

            }
          });

			  }
			  btext = $("#trend_input_content").text();
			  $.fn.trendsInput.updateTagsField(data.real_input,null,btext);


		  });

	  });
    return this;
  };

	$.fn.trendsInput.updateTagsField = function(obj,tagslist, trendText) {
		id = $(obj).attr('id');
		if (tagslist != null){
		  console.log("not null")
	    $("#trends_container").val(tagslist.join(delimiter[id]));
	    $("#trends_form").val(tagslist.join(delimiter[id]));
    }
	  console.log("obj", obj)
	  $(obj).val(trendText);
	};

// START TEST

function setEndOfContenteditable(contentEditableElement)
{
    var range,selection;
    if(document.createRange)//Firefox, Chrome, Opera, Safari, IE 9+
    {
        range = document.createRange();//Create a range (a range is a like the selection but invisible)
        range.selectNodeContents(contentEditableElement);//Select the entire contents of the element with the range
        range.collapse(false);//collapse the range to the end point. false means collapse to end rather than the start
        selection = window.getSelection();//get the selection object (allows you to change selection)
        selection.removeAllRanges();//remove any selections already made
        selection.addRange(range);//make the range you have just created the visible selection
    }
    else if(document.selection)//IE 8 and lower
    {
        range = document.body.createTextRange();//Create a range (a range is a like the selection but invisible)
        range.moveToElementText(contentEditableElement);//Select the entire contents of the element with the range
        range.collapse(false);//collapse the range to the end point. false means collapse to end rather than the start
        range.select();//Select the range (make it the visible selection
    }
}

  // END TEST


	$.fn.trendsInput.importTags = function(obj,val) {
		$(obj).val('');
		id = $(obj).attr('id');
		var tags = val.split(delimiter[id]);
		for (i=0; i<tags.length; i++) {
			$(obj).addTag(tags[i],{focus:false,callback:false});
		}
		if(tags_callbacks[id] && tags_callbacks[id]['onChange'])
		{
			var f = tags_callbacks[id]['onChange'];
			f(obj, tags[i]);
		}
	};

})(jQuery);
