#CSCI E-18 Final Project
##### Harrison DeStefano 

###Overview
My final project is a course catalog web site for the Harvard University Faculty of Arts and Sciences. The catalog is a full-fetrued HTML5 site driven from a flat XML file. To build the application I am using XML, XSLT, XPath  on the backend and jQuery and Bootstrap on the front-end. This project was a lot of fun to complete, I hope you enjoy it as much as I have.

The catalog is construced as a responsive desktop and mobile site.
	    	
###Structure
#### Apache Cocoon

I have opted to use Apache Cocoon to link components together. The Cocoon framework is used to build the pipeline and produce multiple output formats e.g., HTM5, fo2pdf, and text.  The Cocoon pipeline is defined by sitemap.xml file. The sitemap is configured to use query strings as a means to pass parameters between views. Said query strings are used to group or filter the couse data by department, meeting day, meeting time, and instructor. The general workflow for the pipeline is generate, transform, and serialize.

#### File Structure
Harvard University Faculty of Arts and Sciences course data is located in a data folder. Font-end presentation elements and JavaScript specific to the project are located in the CSS, Images and JS folders. The vendors folder is a unique folder where front-end specific files are placed. At no point in time should any items in this folder be modified, unless updating a vendor package. The XSL folder contains all the stylesheets for preforming transformations. This folder is broken into four subfolders, API, Desktop, Fo, and Mobile. The API folder contains stylesheets for JSON transformations. The Desktop and Mobile folders house XSL for displaying desktop and mobile view of the course catalog. The Fo folder contains all the necessary information to transom XML into PDF format.

#### Navigation
The course catalog is divided into three sections, courses, departments, and search. The first two sections, courses and departments, are contextual links that are always present in the navigation. On desktop, a user can navigate to various courses by day of the week or time.
			
The mobile version of the catalog is a simplified version of the desktop. On small devices the navigation links are hidden from view, until needed. When the sandwich button is tapped, the navigation is exposed. Navigation is exposed on tablet or medium devices.
			
The third section of the course catalog is Search, keyword and advanced. A keyword search is always present in the navigation. An advanced search is available from coruse > course search dropdown navigation. This search allows data to be filtered by day, department, instructor, keyword, and term, and time.

I have also included a link to the written project report in said navigation.
	    
###Features
#### HTML

The HTML portion of the project is tackled using the HTML5 and Bootstrap. I am providing a responsive desktop course catalog web site. I have also included a mobile version of the site too. I am using accordions, badges, pagination and tabs throughout the site.

Accordions are a unique feature that combines HTML, CSS, JavaScript to produce a clamshell effect. Large groups of elements are tucked neatly away. An example of this feature can be found on the home page of mobile view the catalogue.

Badges are small yet powerful feature to use. I have implemented badges in the desktop and mobile view of the site. On desktop, the number of search results are captured and presented by way of a badge. On mobile badges are used to display the number of course groups a department has prior to drilling down into the category.
	    	
The number of results returned from a course search can be overwhelming. To make best efforts to wrangle data and breakup results, pagination is introduced. I am used Bootstraps CSS class to handle the display of said pagination.
	    	
			
Another feature to point out, are tabs. I am using tabs to break apart course information to reduce vertical scrolling. An example of this can be found by drilling down to a course on the mobile view of the site.

#### Layout
The catalog layout changes between desktop and mobile view as a means simplify the UI. A good example of this  appears within departments. On desktop the UI contains a two column responsive layout. A department list on the left and AJAX search on the right.The mobile layout throws the desktop UI out for a clean and compact display.
			
#### Searching
A search filed is always present in the user interface, available in or below the navigation bar. This search allows a user to preform a keyword search. The keyword search iterates over the course collection attempting to match text stings. The search is a case insensitive comparison to determine if a sting contains a string.

If the keyword search is not sufficient, the user can preform a deep search by way of the course search form.  The form allows the user to search for courses by, department, meeting day, instructor, meeting time, term, and keyword.


Using XPath various comparisons are made between query string parameters and node values.  If a match is made, the node and or course is grouped, sorted and returned to as a search result.  Should a search return over 450 results, data is paginated.

When keyword searches are made the UI is updated with the search parameter.
	    
###Approach
I stated the catalog working from the final assignment documentation. I created a list of items that needed to be included and what order each item needed to be constructed. Once this was done I turned my attention to the Apache Cocoon site map. I wanted to make best efforts to separate the desktop and mobile resources along with the various vendor plugins. Once I had a good understanding of the project structure, it was time to start the design.
	    
###Design
The course catalogue stated with a rough pencil sketch of what I wanted to see on desktop and mobile views. I created an example wireframe of the site.
	    
###Implementation
From my wireframe I stared to code the various views for desktop and mobile. For the most part I was able to stick with the initial concept, however I ran into a few roadblocks along the way.

Once the initial build was done, I validated the HMLT and CSS using W3C validators. I wanted to confirm my HTML5 markup was valid, CSS was written properly, and the W3C checker hit 80 percent or better. Since my build was local, I had to rely on direct input.
	    
###Highlights
I have created three features that go above and beyond the project specification, API department search, sticky navigation and text truncation.

The API department search feature combines XML, JSON, and AJAX to dynamically look up departments. The aforementioned feature is available on the desktop view of the course catalogue.

On the front-end of the site the user is presented with a input field to enter one or more characters. Once characters are entered, the magic starts to happen as an AJAX request is made to the departments API.
			
The departments API filters the course data for results that match the input. This “filter” is an XPath expression that performs a case insensitive match. Please see /api/departments.xsl for more detail. Once a match is made the results are handed back as JSON.
			
As the user types, GET requests are made to the API for data.
			
If a match is found the UI is updated with a string of text, department name. This string is bound to an on change function that directs the browser to the related department page.

#### Sticky Navigation
To make navigation within departments a smooth process, enter sticky navigation. This feature can be viewed from the desktop version of the site. When a department is on the page with several course groups, the sub-navigation will “stick” as the page is scrolled.
			
This feature is a combination of HTML, CSS, and JavaScript. Please see /js/siteglobal.js for more detail. Essentially, the DOM is watched as the page is scrolled. Once the page pass the height of the sub-navigation container, position:fixed is set. This causes the sub-navigatoin to act “sticky."

#### Text Truncation
In the case of breadcrumb navigation, long titles are annoying. Especially when the title wraps multiple lines increasing vertical page height. If a title is beyond that of an acceptable length, I trunk said title and add an ellipsis.
			
	    
###Lessons Learned

I feel I have a good start the search view and paginating the results, hoverer I feel I am missing the mark. The results need to contain more information about the course. Thus reducing the need to drill down for time, professor, or day of the week.  I would add an additional div containing the information, set said div to display:none. Along side the individual result, a “+” or “details” link would toggle the hidden div.

This semester is my first experience working with XML, XSLT, and XPath. The course catalog as a whole is something to that I am very excited about. I am most proud of the department API to preform department searches. I wish I had stumbled upon this during the start of my final project as I would have developed that API further. Possibly using it to query for a decent amount of data within the mobile views.