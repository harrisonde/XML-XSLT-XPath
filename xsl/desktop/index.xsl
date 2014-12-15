<?xml version="1.0" encoding="utf-8"?>
	<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
 	<xsl:import href="common.xsl"/>
  	<xsl:param name="relpath"/>
  	<xsl:template match="courses"> 
    	<!-- Index page goodness-->
    	<xsl:call-template name="tabs"/>
  	</xsl:template>
 	<!-- 
    	Tabs 
    	Display courses by group in  tab format.
 	-->
	<xsl:template name="tabs">
  		<h2>Browse by course group.</h2>    
	    <div role="tabpanel">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
			    <li role="presentation" class="active"><a href="#A" aria-controls="A" role="tab" data-toggle="tab">A - E</a></li>
			    <li role="presentation"><a href="#B" aria-controls="B" role="tab" data-toggle="tab">F - J</a></li>
			    <li role="presentation"><a href="#C" aria-controls="C" role="tab" data-toggle="tab">K - O</a></li>
			    <li role="presentation"><a href="#D" aria-controls="D" role="tab" data-toggle="tab">N - R</a></li>
			    <li role="presentation"><a href="#E" aria-controls="E" role="tab" data-toggle="tab">U - Z</a></li>

		  	</ul>
		  	<!-- Tab panes -->
			<div class="tab-content">
		  		<div role="tabpanel" class="tab-pane active" id="A">
					<xsl:for-each-group select="
						//course[ substring(course_group, 1,1) = 'A' 
							or 
							substring(course_group, 1,1) = 'B' 
							or 
							substring(course_group, 1,1) = 'C'
							or 
							substring(course_group, 1,1) = 'D'
							or 
							substring(course_group, 1,1) = 'E'
						
						]" 
						group-by="course_group/@code">          
						<xsl:sort select="course_group"/>
						<xsl:variable name="department" select="course_group/@code"/>
						<ul class="course-group">
							<li>
								<a href="{$relpath}groups/group.html?cgroup={ encode-for-uri($department) }" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
						</ul>
					</xsl:for-each-group> 
				</div> 

				<div role="tabpanel" class="tab-pane" id="B">
					<xsl:for-each-group select="
						//course[ substring(course_group, 1,1) = 'F' 
							or 
							substring(course_group, 1,1) = 'G' 
							or 
							substring(course_group, 1,1) = 'H'
							or 
							substring(course_group, 1,1) = 'I'
							or 
							substring(course_group, 1,1) = 'J'
						
						]" 
						group-by="course_group/@code">          
						<xsl:sort select="course_group"/>
						<xsl:variable name="department" select="department/@code"/>
						<ul class="course-group">
							<li>
								<a href="{$relpath}groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
						</ul>
					</xsl:for-each-group> 
				</div> 

				<div role="tabpanel" class="tab-pane" id="C">
					<xsl:for-each-group select="
						//course[ substring(course_group, 1,1) = 'K' 
							or 
							substring(course_group, 1,1) = 'L' 
							or 
							substring(course_group, 1,1) = 'M'
							or 
							substring(course_group, 1,1) = 'N'
							or 
							substring(course_group, 1,1) = 'O'
						
						]" 
						group-by="course_group/@code">          
						<xsl:sort select="course_group"/>
						<xsl:variable name="department" select="department/@code"/>
						<ul class="course-group">
							<li>
								<a href="{$relpath}groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
						</ul>
					</xsl:for-each-group> 
				</div>

				<div role="tabpanel" class="tab-pane" id="D">
					<xsl:for-each-group select="
						//course[ substring(course_group, 1,1) = 'P' 
							or 
							substring(course_group, 1,1) = 'Q' 
							or 
							substring(course_group, 1,1) = 'R'
							or 
							substring(course_group, 1,1) = 'S'
							or 
							substring(course_group, 1,1) = 'T'
						
						]" 
						group-by="course_group/@code">          
						<xsl:sort select="course_group"/>
						<xsl:variable name="department" select="department/@code"/>
						<ul class="course-group">
							<li>
								<a href="{$relpath}groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
						</ul>
					</xsl:for-each-group> 
				</div>

				<div role="tabpanel" class="tab-pane" id="E">
					<xsl:for-each-group select="
						//course[ substring(course_group, 1,1) = 'U' 
							or 
							substring(course_group, 1,1) = 'V' 
							or 
							substring(course_group, 1,1) = 'W'
							or 
							substring(course_group, 1,1) = 'X'
							or 
							substring(course_group, 1,1) = 'Y'
							or 
							substring(course_group, 1,1) = 'Z'
						
						]" 
						group-by="course_group/@code">          
						<xsl:sort select="course_group"/>
						<xsl:variable name="department" select="department/@code"/>
						<ul class="course-group">
							<li>
								<a href="{$relpath}groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
						</ul>
					</xsl:for-each-group> 
				</div>
			</div>	
		</div>	
	</xsl:template>
</xsl:stylesheet>