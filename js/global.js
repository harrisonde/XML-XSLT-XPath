/**
* global.js
*
* Harvard CSCIE 18
* Developer: Harrison DeStefano
*
* Client-side functions for use with Harvard final project
**/
HARVARD = {

	WHD: {

		/**
		* All the page load functions are called via reference
		**/
		pageLoad: function(){
			HARVARD.WHD.welcome();
			HARVARD.WHD.ui.ajaxSelect();
			HARVARD.WHD.ui.stickyNav();
		},

		/**
		* Environment variables
		**/
		environment: {

			dev: ['10.0.0.13', 'http://localhost:8080/'],

			prod: 'final.harrisondestefano.com'

		},

		/**
		* Devlompment based goodness
		**/
		welcome : function(){

			if(window.location.hostname.indexOf(HARVARD.WHD.environment.prod) === -1)
			{
				HARVARD.logSafe('Hello. I see you are in development. Great, I\'ll be providing you all sorts of good information!'); 

				for(var i = 0; i < HARVARD.WHD.environment.dev.length; i++)
				{
					HARVARD.logSafe('Dev environment option ' + (i + 1) + ': ' + HARVARD.WHD.environment.dev[i]); 
				}
			}
		},
		/**
		* All client side user invoked events
		**/
		ui : {

			ajaxSelect: function (){
				var aipUri, endpoint, uri;
				uri= window.location.href;
				apiUri = uri.substring(uri, uri.lastIndexOf("/departments")) + '/api/departments.html';
				$("#department-search-js").select2({
				    placeholder: "Search for a department",
				    minimumInputLength: 1,
				    ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
				        url: apiUri,
				        dataType: 'json',
				        quietMillis: 250,
				        // Function to generate query parameters for the ajax request.
				        data: function (term, page) {
				            return {
				                q: term, // search term
				            };
				        },
				        // Function used to build the query results object from the ajax response
				        results: function (data, page) { // parse the results into the format expected by Select2.
				            // since we are using custom formatting functions we do not need to alter the remote JSON data
				            return { results: data };
				        },
				        cache: true
				    },
				    dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
				    escapeMarkup: function (m) { return m; }, // we do not want to escape markup since we are displaying html in results
					// id, formatSelection, and formatResult required for mathing on custom key
				    id: 'department',
  					formatSelection: function (item) { return item.department; },
  					formatResult: function (item) { 
  						var markup, uri, departmentUri;
  						uri= window.location.href;
						departmentUri = uri.substring(uri, uri.lastIndexOf("/")+1)
  						markup = '<div><p>'+item.department+'</p></div>';
  						return markup; 
  					}
				});
				// event to mimic user click event
				$("#department-search-js").on("change", function(e) { 
					console.log('change');
					var selectedOption, uri 
					selectedOption = $(this).select2('data');
					uri= window.location.href;
					window.location = uri.substring(uri, uri.lastIndexOf("/")+1) + selectedOption.uri;	
				});
			},
			stickyNav: function(){
				/**
				* Watch the page offset and make the navigation sticky.
				* For use only with features template.
				**/	
				function elmInView(elm){
					var documentTop, elmBottom;
					documentTop = jQuery(window).scrollTop();		    
				    elmBottom = jQuery(elm).offset().top + jQuery(elm).outerHeight();
					return elmBottom <= documentTop;
				}
				// Set event listener bond to window scroll event
				$(window).on('scroll', function(){
					var navElm = $('.course_nav');
					var watchElm = $('.page-header');
					var inView = elmInView(watchElm);
					switch(inView)
					{
						case true:
							navElm.not('.sticky-no-show-js').addClass('sticky-js');
						break;
						case false:
							navElm.removeClass('sticky-js');
						break;
					}	
				});
				// Update the UI accoding to user events
				$('.course_nav a').on('click', function(){
					$(this).addClass('current');
					$(this).siblings().removeClass('current');
				});
				$('.course_nav .empty').parent().remove();
				$('.sticky-close-js').on('click', function(){
					$('.course_nav').removeClass('sticky-js').addClass('sticky-no-show-js');
				});
			}
		}

	},

	/**
	* Safe loging of any front-end information against environment(s)
	**/
	logSafe :  function(msg){ 
		if(typeof console !== undefined)
		{ 
			console.log(msg);
			return 1; 
		} 
		return 0; 
	},

}

/**
* Run once Document Object Model (DOM) is ready for JavaScript code to execute.
**/
$(document).ready(function() {
	
	HARVARD.WHD.pageLoad();

});