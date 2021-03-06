$(document).ready(function() {
	
	// MAKE ALL THE PICTURES PRETTY
	$('.rss_item').each(function() {
		var img = $("img", this);
		var src = img.attr("src");
		var pretty_div = "<div class='center_cropped rss_thumb' style='background-image:url(" + src + ");'><br></div>";
		$(this).prepend(pretty_div);
	});

	// ADD EVENT HANDLERS TO THE SAVE BUTTONS
	$(".save_button").click(function(){
		// Let the user know it is loading
		var loading_img = "<img class='loading' src='loading.gif'>"
		$(this).html(loading_img);
		var button = $(this);
		// Ajax the data
		$.ajax({
    		type: "POST",
    		url: "/save",
    		data: {
    			guid: $(this).data("guid"),
    			link: $(this).data("link"),
    			pubdate: $(this).data("pubdate"),
    			title: $(this).data("title"),
    			description: $(this).data("description")
    		},
    		success: function(output){
    		    if (output[0] === "0") { // the save was successful
    		    	button.html("✔ Saved");
    		    	button.addClass("disabled_button");
    		    	button.off("click");
    		    } else {
    		    	button.html("✔ Already saved");
    		    	button.addClass("disabled_button");
    		    	button.off("click");
    		    }
    		}
		});
	});

    // ADD EVENT HANDLERS TO THE DELETE BUTTON
    $(".delete_button").click(function(){
        var loading_img = "<img class='loading' src='loading.gif'>"
        $(this).html(loading_img);
        var button = $(this);

        $.ajax({
            type: "POST",
            url: "/delete",
            data: {
                id: $(this).data("id")
            },
            success: function(output){
                if (output[0] === "0") { // the detete was successful
                    button.closest(".rss_item").fadeOut();
                } else {
                    button.html("X");
                }
            }
        });
    });

    // REMOVE THE FEED LOADING DIV
	$('.feed_loading').removeClass('feed_loading');
	$('.rss_feed').css("z-index", "initial");
});