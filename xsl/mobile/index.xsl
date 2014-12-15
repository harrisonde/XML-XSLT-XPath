<?xml version="1.0" encoding="utf-8"?>
	<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
 	<xsl:import href="common.xsl"/>
  	<xsl:param name="relpath"/>
  	<xsl:template match="courses"> 
    	<!-- Index page goodness-->
    	<xsl:call-template name="accordion"/>
  	</xsl:template>
 	<!-- 
    	Tabs 
    	Display courses by group in accordion format.
 	-->
	<xsl:template name="accordion">
  		<h6>Browse by course group.</h6>    
	  		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
		  		<!-- Group 1 -->
		  		<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingOne">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
				         	Course Groups A - E
				        </a>
				      </h4>
				    </div>
				    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
      					<div class="panel-body">
							<ul class="course-group">
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
									
										<li>
											<a class="btn btn-default" href="{$relpath}mobile/groups/group.html?cgroup={ encode-for-uri($department) }" title="course_group">
												<xsl:value-of select="course_group"/>
											</a>
										</li>		
								</xsl:for-each-group> 
							</ul>
						</div>
					</div>
				</div>
				<!-- Group 2 -->
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingTwo">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
				         	Course Groups F - J
				        </a>
				      </h4>
				    </div>
				    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      					<div class="panel-body">
								<ul class="course-group">
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
						<xsl:variable name="department" select="course_group/@code"/>
					
							<li>
								<a class="btn btn-default" href="{$relpath}mobile/groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
						
					</xsl:for-each-group> 
						</ul>
						</div>
					</div>
				</div>
				<!-- Group 3 -->
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingThree">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
				         	Course Groups K - O
				        </a>
				      </h4>
				    </div>
				    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      					<div class="panel-body">
      						<ul class="course-group">
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
						<xsl:variable name="department" select="course_group/@code"/>
						
							<li>
								<a class="btn btn-default" href="{$relpath}mobile/groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
					</xsl:for-each-group> 
							</ul>
						</div>
					</div>
				</div>
				<!-- Group 4 -->
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingFour">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
				         	Course Groups P - T
				        </a>
				      </h4>
				    </div>
				    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
      					<div class="panel-body">
      						<ul class="course-group">
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
						<xsl:variable name="department" select="course_group/@code"/>
							<li>
								<a class="btn btn-default" href="{$relpath}mobile/groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
					</xsl:for-each-group>
							</ul> 
						</div>
					</div>
				</div>
				<!-- Group 5 -->
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingFive">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="true" aria-controls="collapseFive">
				         	Course Groups U - Z
				        </a>
				      </h4>
				    </div>
				    <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
      					<div class="panel-body">
      						<ul class="course-group">
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
						<xsl:variable name="department" select="course_group/@code"/>
						
							<li>
								<a class="btn btn-default" href="{$relpath}mobile/groups/group.html?cgroup={encode-for-uri($department)}" title="course_group">
									<xsl:value-of select="course_group"/>
								</a>
							</li>	
					</xsl:for-each-group> 
						</ul>
						</div>
					</div>
				</div>

			</div>	
				 
				
	</xsl:template>
</xsl:stylesheet>