/*

	jQuery Tags Input Plugin 1.3.1

	Copyright (c) 2011 XOXCO, Inc

	Documentation for this plugin lives here:
	http://xoxco.com/clickable/jquery-tags-input

	Licensed under the MIT license:
	http://www.opensource.org/licenses/mit-license.php

	ben@xoxco.com

*/

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
	            $('<a contenteditable="false" data-is-processed="1" style="margin: 0 5px 0 1px; width: auto; background: green; color: white; padding: 0 2px 0 2px;" class="tag">').text(value),
	            $("</a>")
            );
              // $('<span>').addClass('tag').attr('id','tag_'+(trend_number+"")).append(
              //                 $('<span>').text(value).append('&nbsp;&nbsp;'),
              //                 $('<a>', {
              //                     href  : '#',
              //                     title : 'Removing tag',
              //                     id: trend_number+"",
              //                     text  : 'x'
              //                 }).click(function () {
              //                    return $('#' + id).removeTag(escape(value), this);
              //                 })
              //             )).insertBefore('#' + id + '_addTag');

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

          // $('#'+id+'_tag').val('');
          // if (options.focus) {
          //  $('#'+id+'_tag').focus();
          // } else {
          //  $('#'+id+'_tag').blur();
          // }

					// if (options.callback && tags_callbacks[id] && tags_callbacks[id]['onAddTag']) {
					//             var f = tags_callbacks[id]['onAddTag'];
					//             f(value);
					//           }
					//           if(tags_callbacks[id] && tags_callbacks[id]['onChange'])
					//           {
					//             var i = tagslist.length;
					//             var f = tags_callbacks[id]['onChange'];
					//             f($(this), tagslist[i]);
					//           }
				}
        $.fn.trendsInput.updateTagsField(this,tagslist,inputTrendText);

			return false;
		};

	$.fn.removeTag = function(value, num) {
			value = unescape(value);
			this.each(function() {
				id = $(this).attr('id');
				tag_num = $(num).attr("id");

        // div = $("#"+id +"_tagsinput span").find("#tag_"+tag_num);
				var old = $(this).val().split(delimiter[id]);

        $('#'+id+'_tagsinput ' +"#tag_"+tag_num).remove();
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
        // $(tagslist[num]).remove();
        // console.log(tagslist)

        $("#trends_form").val(tagslist)

				if (tags_callbacks[id] && tags_callbacks[id]['onRemoveTag']) {
					var f = tags_callbacks[id]['onRemoveTag'];
					f(value);
				}
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
        // fake_input: '#'+id+'_tagsinput' //CHANGED FROM _tag
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

			console.log("id", id)

			$(markup).insertAfter(this);

			$("#trend_input_content").css('width',settings.width);
			$("#trend_input_content").css('height',settings.height);


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
               console.log("text", input_stuff)
               console.log("trend",input_trend)
               $.fn.addTag(input_trend, input_stuff);
               atext = $("#trend_input_content").text();
               test = atext.toString();
               pos = test.length
               $("#add_tag").blur().remove();
               $("#trend_input_content").focus();
               var divy = document.getElementById("trend_input_content");
               divy.onkeypress = function(evt) {
                   evt = evt || window.event;
                   var charCode = (typeof evt.which == "undefined") ? evt.keyCode : evt.which;
                   if (charCode) {
                       var charStr = String.fromCharCode(charCode);
                       var greek = convertCharToGreek(charStr);
                       insertTextAtCursor(greek);
                       return false;
                   }
               }

               return false;

            }
          });

			  }
		  });

	  });
    return this;
  };

	$.fn.trendsInput.updateTagsField = function(obj,tagslist, trendText) {
		id = $(obj).attr('id');
	  $("#trends_container").val(tagslist.join(delimiter[id]));
	  $("#trends_form").val(tagslist.join(delimiter[id]))
	  $(obj).val(trendText);
	};

// START TEST
  var greekChars = {
      "a": "\u03b1"
      // Add character mappings here
  };

//   http://stackoverflow.com/questions/2940882/need-to-set-cursor-position-to-the-end-of-a-contenteditable-div-issue-with-sele
//
  function convertCharToGreek(charStr) {
      return greekChars[charStr] || "[Greek]";
  }

  function insertTextAtCursor(text) {
      var sel, range, textNode;
      if (window.getSelection) {
          sel = window.getSelection();
          if (sel.getRangeAt && sel.rangeCount) {
              range = sel.getRangeAt(0);
              range.deleteContents();
              textNode = document.createTextNode(text);
              range.insertNode(textNode);

              // Move caret to the end of the newly inserted text node
              range.setStart(textNode, textNode.length);
              range.setEnd(textNode, textNode.length);
              sel.removeAllRanges();
              sel.addRange(range);
          }
      } else if (document.selection && document.selection.createRange) {
          range = document.selection.createRange();
          range.pasteHTML(text);
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
