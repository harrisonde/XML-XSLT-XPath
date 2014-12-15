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

			tbd: function (){

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