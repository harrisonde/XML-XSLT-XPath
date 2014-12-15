<?xml version="1.0" encoding="utf-8"?>
  <!--
    Groups.xsl
      
    Harrison DeStefano
    williamdestefano@harvard.fas.edu

    Define templates for the course groups and display related group information.

    usage: map:match 
  -->
  <xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:import href="common.xsl"/>
  <xsl:param name="relpath"/> 
  <xsl:param name="querystring"/> 
  <xsl:param name="url"/> 
   <!-- Make a sequence of "parameter=value" from the query string -->
  <xsl:variable name="course_group_param_seq">
    <xsl:analyze-string select="$querystring" regex="cgroup=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable> 

  <xsl:template match="//courses">
    <xsl:choose>
      <xsl:when test="$course_group_param_seq = ''">
          <p>no course group found</p>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="department_courses"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
    Department Courses 
    Display all the courses for a given department
  -->
  <xsl:template name="department_courses">

      <!-- Group, itterate, and sort -->     
      <xsl:for-each-group select="course" group-by="course_group/@code">
        <!-- 
          Check the current department code against the query string params. The query string is 
          split by "=" and pull last item of array. 
        -->
        <xsl:if test="course_group/@code = $course_group_param_seq 
          or 
          course_group/@code = replace($course_group_param_seq, '%20', ' ')
          or
          course_group/@code = replace($course_group_param_seq, '%26', '&#38;')
          ">
          <!-- 
            pdf 
            Provide a link to pdf the curret view.
          -->
          <p class="pdf-view">
            <a href="{$relpath}departments/groups.pdf?dept={department/@code}&#38;deptl={encode-for-uri(department/dept_long_name)}">
              <img class="icon" alt="pdf" src="{$relpath}images/pdf.png"/>
            </a>
          </p>
          <xsl:sort select="department/@code"/>
          <!--
            Get department/course data
          -->
          <div>
          <xsl:call-template name="department_course_data"/>  
          </div>
        </xsl:if>

      </xsl:for-each-group> 
  
  </xsl:template>
  
  <!-- 
    Department course data 
    Build the department and course data such as department short name, course number, term, and title.
  --> 
  <xsl:template name="department_course_data">
    <!-- group each by course group -->
    <xsl:for-each-group select="current-group()" group-by="course_group/@code">
      <!-- First element in node add table heading -->
      <xsl:if test="count(current-group()) != 0">
        <h5 id="{course_group/@code}">  
          <xsl:value-of select="course_group"/>
        </h5>
      </xsl:if> 
      <!-- build accordion elements--> 
      <!-- Sort, format, and echo course information --> 
        <table class="table table-striped table-bordered">
          <tr>
            <th>Number</th>
            <th>Term</th>
            <th>Title</th>
          </tr> 
          <xsl:for-each select="current-group()">
            <xsl:sort select="course_number/num_int"/>
            <!-- course title, number, and uri -->
            <tr>
              <!-- number -->
              <td class="number">
                <a href="{$relpath}courses/course.html?catnum={@cat_num}" title="{title}">
                  <xsl:value-of select="department/dept_short_name"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="course_number/num_int"/>
                </a>
              </td>
              <!-- term -->
              <td class="term">
                  <xsl:choose>
                    <xsl:when test="term/@fall_term != 'Y'">
                    <xsl:text>Spring</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                    <xsl:text>Fall</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
              </td>
              <!-- title -->
              <td class="title">
                <a href="{$relpath}courses/course.html?catnum={@cat_num}" title="{title}">
                  <xsl:value-of select="title"/> 
                </a>  
              </td>
            </tr>
          </xsl:for-each> 
        </table>
    </xsl:for-each-group>  
  </xsl:template>
   <!-- 
    Departments 
    Itterate over data and echo the department name, uri, title, and include a hash on uri to 
    make navigation easy.
    -->
  <xsl:template name="department_internal_nav">
      <h5>Departments</h5>
      <!-- 
       We only want unique department short names as short name is used identify 
       what department courses to display in the "list" view. 
       We also use encodes reserved characters in an xs:string that is intended to be used in the 
       path segment of a URI. Adding this just incase we get a joker adding odd things to the 
       model.
        -->
        <ul class="departments"> 
          <xsl:for-each-group select="//course" group-by="department">
            <xsl:sort select="department/dept_short_name"/>
            <li>
              <!--
               Add class to current department
              -->
              <xsl:choose>
                <xsl:when test="department/@code = $dept_param_seq or department/@code = replace($dept_param_seq, '%20', ' ')">
                  <a class="current" href="{$relpath}departments/department.html?dept={encode-for-uri(department/@code)}" title="{department/dept_short_name}">
                    <xsl:value-of select="department/dept_short_name"/>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="{$relpath}departments/department.html?dept={encode-for-uri(department/@code)}" title="{department/dept_short_name}">
                    <xsl:value-of select="department/dept_short_name"/>
                  </a>
                </xsl:otherwise>
              </xsl:choose>
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
        <a href="{$relpath}index/home.html">Home</a>    
      </li>
      <li>
        <img class="" alt="arrow" src="{$relpath}images/arrow.gif"/>
      </li> 
      <li class="current">
        Groups
      </li>
    </ul>  
  </xsl:template> 

 

</xsl:stylesheet>
