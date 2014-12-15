<?xml version="1.0" encoding="utf-8"?>
  <!--
    Department.xsl
      
    Harrison DeStefano
    williamdestefano@harvard.fas.edu

    Define templates for the department and display related department information.

    usage: map:match 
  -->
  <xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:import href="common.xsl"/>
  <xsl:param name="relpath"/> 
  <xsl:param name="q_str"/> 
  <xsl:param name="url"/> 
   <!-- Make a sequence of "parameter=value" from the query string -->
  <xsl:variable name="dept_param_seq">
    <xsl:analyze-string select="$q_str" regex="dept=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable>
  <xsl:variable name="course_group_param_seq">
    <xsl:analyze-string select="$q_str" regex="cgroup=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable> 

  <xsl:template match="//courses">
    <xsl:choose>
      <xsl:when test="$dept_param_seq = '' and $course_group_param_seq = ''">
        <xsl:call-template name="departments"/>
      </xsl:when>
      <xsl:when test="$dept_param_seq != ''">
        <xsl:call-template name="department_group"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="department_courses"/>
      </xsl:otherwise>
    </xsl:choose>  
  </xsl:template>
  
  <!-- 
    Departments 
  -->
  <xsl:template name="departments">
    <ul class="list-group">
      <xsl:for-each-group select="//course" group-by="department">
        <xsl:sort select="department/dept_short_name"/>
        <li class="list-group-item"> 
          <a href="{$relpath}mobile/departments/department.html?dept={encode-for-uri(department/@code)}" title="{department/dept_short_name}">
            <xsl:value-of select="department/dept_short_name"/>
          </a>
          <!-- Get total number of courses offered by department and display -->
          <span class="badge">  
            <xsl:value-of select="count(current-group())"/>
          </span>  
            
        </li>    
      </xsl:for-each-group>
    </ul>  
  </xsl:template>

 <!-- 
    Department Group
 -->
  <xsl:template name="department_group">
    <ul class="list-group">
      <xsl:for-each-group select="//course[department/@code = $dept_param_seq]" group-by="course_group/@code">
        <li class="list-group-item"> 
          <a href="{$relpath}mobile/departments/department.html?cgroup={encode-for-uri(course_group/@code)}" title="{department/dept_short_name}">
            <xsl:value-of select="course_group"/>
          </a>  
          <span class="badge">  
            <xsl:value-of select="count(current-group())"/>
          </span>

        </li>  
      </xsl:for-each-group>
    </ul>  
  </xsl:template>
  <!-- 
    Department courses
  -->
  <xsl:template name="department_courses">
    <ul class="list-group">
      <xsl:for-each-group select="//course[course_group/@code = $course_group_param_seq]" group-by="title">
        <li class="list-group-item"> 
          <a href="{$relpath}mobile/courses/course.html?catnum={@cat_num}" title="{department/dept_short_name}">
            <xsl:value-of select="title"/>
          </a>  
        </li>
      </xsl:for-each-group>
    </ul>  
  </xsl:template>

  <!-- 
    Navigation 
    Override the default style sheet from common and build main navigtaion
  -->
  <xsl:template name="navigation">
    <ul class="breadcrumbs">
      <li>  
      <a href="{$relpath}mobile/index/home.html">Home</a>    
      </li>
      <li>
        /
      </li> 
      <li class="current">
        Departments
      </li>
     </ul>  
  </xsl:template> 

</xsl:stylesheet>
