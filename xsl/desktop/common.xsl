<?xml version="1.0" encoding="utf-8"?>
	<!--
	  Common.xsl
	    
	  Harrison DeStefano
	  williamdestefano@harvard.fas.edu

	  Define templates for the body, branding, navigation, page title, and footer.

	  usage: xsl:import  
	-->
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns="http://www.w3.org/1999/xhtml">  
		<xsl:param name="url"/>  
		<xsl:param name="relpath"/>
		 <xsl:param name="q_str"/> 
		<!-- Make a sequence of "parameter=value" from the query string -->
		  <xsl:variable name="dept_param_seq">
		    <xsl:analyze-string select="$q_str" regex="dept=([^&amp;]*)">
		      <xsl:matching-substring>
		        <xsl:sequence select="regex-group(1)"/>
		      </xsl:matching-substring>
		    </xsl:analyze-string>
		  </xsl:variable>
		  <xsl:variable name="course_param_seq">
		    <xsl:analyze-string select="$q_str" regex="course=([^&amp;]*)">
		      <xsl:matching-substring>
		        <xsl:sequence select="regex-group(1)"/>
		      </xsl:matching-substring>
		    </xsl:analyze-string>
		  </xsl:variable>  

		<xsl:template match="document-node()">    		
			
			<html xmlns="http://www.w3.org/1999/xhtml">      
				<head>  
					<!-- 
		      			Specifies the character encoding for the document
	      			-->
	        		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	      			<!--
	        			Get default vendor styles
	       			 -->
	         		<xsl:call-template name="vendor_css"/>
	         		<!--
	        			Get site styles
	       			 -->
	         		<xsl:call-template name="site_css"/>
					<!--
	        			Set scale for mobile devices
	       			 -->
	         		<meta name="viewport" content="width=device-width, initial-scale=1" />
					 <!--
	        			Set page title
	       			 -->
					<title>Harvard University, Faculity of Arts &amp; Sciences</title>        	
				</head>      
				<body>        
					<div class="container">          
						<!-- use to help debug path issues 					
					    <div class="debugBar bg-success">
					      <p>rel path: <xsl:value-of select="$relpath"/></p>
					      <p>url: <xsl:value-of select="$url"/></p>
					      <p>department code: <xsl:value-of select="$dept_param_seq"/></p>    
					      <p>course code: <xsl:value-of select="$course_param_seq"/></p>     
					    </div> -->	
						<div class="row page-header">            
							<!-- header -->
							<div class="header">	
								<div class="col-xs-12">
									<xsl:call-template name="branding"/>  
								</div>
								<div class="col-xs-12">
									<!-- navigation -->
									<xsl:call-template name="navigation"/>
									<!-- page title -->
									<xsl:call-template name="page_title"/> 
								</div>
							</div>	         
						</div>          
						<div class="row">            
							<div class="col-xs-12">
								<!-- primary -->            
								<div id="main">              
									<xsl:apply-templates />            
								</div> 
							</div>	         
						</div>          	
						<div class="row">    
							<div class="col-xs-12">        
								<!-- footer -->            
								<div id="footer">              
									<xsl:call-template name="footer"/>            
								</div>          
							</div>
						</div>        
					</div>   
					<!--
        				Get defulat vendor javascript(s)
       				-->
					<xsl:call-template name="vendor_js"/>   
					<!--
        				Client-side functions for use with Harvard final project
       				-->
					<script src="{$relpath}js/global.js" type="text/javascript">&#160;</script>
				</body>    
			</html>  
		</xsl:template> 
		
		<!-- Branding --> 
		<xsl:template name="branding">
			<nav class="navbar navbar-default" role="navigation">
  				<div class="container-fluid">
	   				<!-- Brand and toggle get grouped for better mobile display -->
	    			<div class="navbar-header">
				    	<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					        <span class="sr-only">Toggle navigation</span>
					        <span class="icon-bar">&#160;</span>
					        <span class="icon-bar">&#160;</span>
					        <span class="icon-bar">&#160;</span>
					    </button>
	      				<a href="{$relpath}index/home.html">	
	      					<img class="logo pull-left" alt="logo" src="{$relpath}images/harvard_shield.png"/>
	    				</a>	
	    			</div>
					<!-- Collect the nav links, forms, and other content for toggling -->
	    			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				      <ul class="nav navbar-nav">
				      	 <li class="dropdown">
				          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Course <span class="caret">&#160;</span></a>
				          	<ul class="dropdown-menu" role="menu">
				         		<li>
				         			<a href="{$relpath}courses/course.html">Courses by day</a>
				         		</li>
				         		<li>
				         			<ul>
					         			<li>
					         				<a href="{$relpath}courses/course.html?day=1">Monday</a>
					         			</li>
					         			<li>
					         				<a href="{$relpath}courses/course.html?day=2">Tuesday</a>
					         			</li>
					         			<li>
					         				<a href="{$relpath}courses/course.html?day=3">Wednesday</a>
					         			</li>
					         			<li>
					         				<a href="{$relpath}courses/course.html?day=4">Thrusday</a>
					         			</li>
					         			<li>
					         				<a href="{$relpath}courses/course.html?day=5">Friday</a>
					         			</li>
					         			<li>
					         				<a href="{$relpath}courses/course.html?day=6">Saturday</a>
					         			</li>
				         			</ul>	
				         		</li>	
				         		<li>
				         			<a href="{$relpath}courses/course.html">Courses by time</a>
				         		</li>
				         		<li>
				         			<ul>
					         			<li>
					         				<a href="{$relpath}courses/course.html?begin_time=1130">Morning</a>
					         			</li>
					         			<li>
					         				<a href="{$relpath}courses/course.html?begin_time=1630">Afternoon</a>
					         			</li>
					         			<li>
					         				<a href="{$relpath}courses/course.html?begin_time=2100">Night</a>
					         			</li>
				         			</ul>	
				         		</li>
				         		<li class="divider">.</li>
				         		<li>
				         			<a href="{$relpath}search/course.html">Courses Search</a>
				         		</li>
				         	</ul>
				         </li>		
				         <li class="dropdown">
					          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Department <span class="caret">&#160;</span></a>
						        <ul class="dropdown-menu" role="menu"> 
							         <li>
						         		<a href="{$relpath}departments/department.html">Department Search</a>
						         	</li>
					         	</ul>	
					    </li>
					    <li>
					    	<a href="{$relpath}docs/report.html">Report</a>
					    </li>
				      </ul>
				      <ul class="nav navbar-nav navbar-right">
				      	<li class="hidden-xs">
					    	<form action="{$relpath}search/course.html" method="GET" class="navbar-form navbar-left pull-right" role="search">
					    		<!-- hidden input fields -->
      							<input type="hidden" name="pid" value="1"/>
      							<input type="hidden" name="dept" value=""/>
      							<input type="hidden" name="day" value=""/>
      							<input type="hidden" name="begin_time" value=""/>
      							<input type="hidden" name="inst" value=""/>	

						        <div class="form-group">
						          <input name="ftxt" type="text" class="form-control" placeholder="Search"/>
						        </div>
						        <button type="submit" class="btn btn-default">Submit</button>
						    </form>
					    </li>
				      </ul>  
				   	</div><!-- /.navbar-collapse -->
			  	</div><!-- /.container-fluid -->
			</nav>
		</xsl:template> 

		<!-- 
			Decode URI 
			This is a very basic replace of url encoded characters. Adding template 
			here as I might want to call in various locations.
		-->
      	<xsl:template name="decode_uri">
			<xsl:param name="encoded_uri_string"/>
			<xsl:variable name="plus_escaped" select="translate($encoded_uri_string, '+', ' ')"/>
			<xsl:variable name="elx_escaped" select="replace($plus_escaped, '%21', '&#33;')"/>
			<xsl:variable name="quote_escaped" select="replace($elx_escaped, '%22', '&#34;')"/>
			<xsl:variable name="hash_escaped" select="replace($quote_escaped, '%23', '&#35;')"/>
			<!-- Dollar sign  throws errors -->
			<xsl:variable name="dlr_escaped" select="replace($hash_escaped, '%24', '')"/>
			<xsl:variable name="pcnt_escaped" select="replace($dlr_escaped, '%25', '&#37;')"/>
			<xsl:variable name="amp_escaped" select="replace($pcnt_escaped, '%26', '&#38;')"/>
			<!-- Single quote throws errors -->
			<xsl:variable name="squot_escaped" select="replace($amp_escaped, '%27', '')"/>
			<xsl:variable name="prnl_escaped" select="replace($squot_escaped, '%28', '&#40;')"/>
			<xsl:variable name="prnr_escaped" select="replace($prnl_escaped, '%29', '&#41;')"/>
			<xsl:variable name="str_escaped" select="replace($prnr_escaped, '%29', '&#41;')"/>
			<xsl:variable name="pls_escaped" select="replace($str_escaped, '%2B', '&#32;')"/>
			<xsl:variable name="coma_escaped" select="replace($pls_escaped, '%2C', '&#44;')"/>
			<xsl:variable name="dash_escaped" select="replace($coma_escaped, '%2D', '&#45;')"/>
			<xsl:variable name="perd_escaped" select="replace($dash_escaped, '%2E', '&#46;')"/>
			<xsl:variable name="bslash_escaped" select="replace($perd_escaped, '%2F', '&#47;')"/>
			<xsl:variable name="num_zero_escaped" select="replace($bslash_escaped, '%30', '0')"/>
			<xsl:variable name="num_one_escaped" select="replace($num_zero_escaped, '%31', '1')"/>
			<xsl:variable name="num_two_escaped" select="replace($num_one_escaped, '%32', '2')"/>
			<xsl:variable name="num_three_escaped" select="replace($num_two_escaped, '%33', '3')"/>
			<xsl:variable name="num_four_escaped" select="replace($num_three_escaped, '%34', '4')"/>
			<xsl:variable name="num_five_escaped" select="replace($num_four_escaped, '%35', '5')"/>
			<xsl:variable name="num_six_escaped" select="replace($num_five_escaped, '%36', '6')"/>
			<xsl:variable name="num_seven_escaped" select="replace($num_six_escaped, '%37', '7')"/>
			<xsl:variable name="num_eight_escaped" select="replace($num_seven_escaped, '%38', '8')"/>
			<xsl:variable name="num_nine_escaped" select="replace($num_eight_escaped, '%39', '9')"/>
			<xsl:value-of select="$num_nine_escaped"/>
		</xsl:template>	

		<!-- Navigation --> 
		<xsl:template name="navigation">
			<ul class="breadcrumbs">
				<li class="current">Home</li>
			</ul>	
		</xsl:template>  

		<!-- Display page title -->
		<xsl:template name="page_title">
			<h2 class="logo-text pull-left">Harvard University, Faculity of Arts &amp; Sciences Course Catalog</h2>  
	  	</xsl:template>
	  	

		<!-- Footer --> 
		<xsl:template name="footer">
			<hr/>
			<img class="logo pull-left" alt="logo" src="{$relpath}images/harvard_shield.png"/>
			<h1 class="small">Harvard University, Faculity of Arts &amp; Sciences</h1>
		</xsl:template>
		
		<!-- Site css -->
		<xsl:template name="site_css">
			<!-- Import Bootstrap -->
       		 <link rel="stylesheet" href="{$relpath}css/desktop.css" type="text/css" media="screen, projection" />
		</xsl:template>  

		<!-- Vendor css -->
		<xsl:template name="vendor_css">
			<!-- Import Bootstrap -->
       		 <link rel="stylesheet" href="{$relpath}vendors/bootstrap-3.2.0-dist/css/bootstrap.min.css" type="text/css" media="screen, projection"/>
       		 <!-- Import Select2 -->
       		 <link rel="stylesheet" href="{$relpath}vendors/select2-3.5.2/select2.css" type="text/css" media="screen, projection"/>
		</xsl:template>  
		
		<!-- Vendor javascript -->
		<xsl:template name="vendor_js">
			<!-- Import jQuery -->
       		<script type="text/javascript" src="{$relpath}vendors/jquery-1.11.1-dist/jquery-1.11.1.min.js">&#160;</script>
			<!-- Import Bootstrap -->
       		<script type="text/javascript" src="{$relpath}vendors/bootstrap-3.2.0-dist/js/bootstrap.min.js">&#160;</script>
       		<!-- Import Select2 -->
       		<script type="text/javascript" src="{$relpath}vendors/select2-3.5.2/select2.js">&#160;</script>
		</xsl:template>  

</xsl:stylesheet>