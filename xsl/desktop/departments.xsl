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

  <xsl:template match="//courses">
    <div class="col-xs-3 departments-list">
      <xsl:call-template name="department_internal_nav"/>
    </div>
    <div class="col-xs-9">
      <xsl:choose>
        <xsl:when test="$dept_param_seq = ''">
            <!-- 
              The following language is taken from http://www.extension.harvard.edu/courses
              and is the property of Harvard University.
            -->
            <h1>Department Search</h1> 
            <h2>Find a department and view the courses offered.</h2>
            <div class="select-two-js">
              <div id="department-search-js">&#160;</div>
            </div> 
            <p class="select-two-js">Eget phasellus suscipit libero bibendum vestibulum condimentum a curabitur pellentesque, nec faucibus aliquam ornare metus hac viverra lacinia class luctus, nostra lacinia dictumst nisl</p> <p>lectus ultrices vestibulum facilisis. Auctor platea porttitor neque fermentum odio urna quam hendrerit mauris velit, viverra elementum primis platea adipiscing justo adipiscing ullamcorper convallis, lacus enim sapien maecenas lobortis eget gravida egestas tempus. Tristique consequat lacus donec at curae lacinia aliquam potenti iaculis, donec commodo dictumst senectus laoreet dictumst consectetur dictum pretium,</p>
             
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="department_courses"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
  
   <!-- 
    Course navigation 
    Create internal navigation for department courses using url hash
  --> 
  <xsl:template name="course_navigation">
    <!-- navigation -->
    <xsl:for-each-group select="current-group()" group-by="course_group/@code">     
       <!-- 
          Print navigation only when necessary ie not the only department in the course.
        -->
        <xsl:choose>              
          <xsl:when test="count(current-group()) != 0 and position() != last()">
            <a href="department.html?{$q_str}#{course_group/@code}">  
              <xsl:value-of select="course_group"/> 
            </a>
            <span> | </span>
          </xsl:when>
          <xsl:when test="position() != 1 and position() = last()">
            <a href="department.html?{$q_str}#{course_group/@code}">  
              <xsl:value-of select="course_group"/>
            </a>
            <!-- close button -->
            <span class="sticky-close-js">X</span>
          </xsl:when>
          <xsl:otherwise>
            <div class="empty"><xsl:text> </xsl:text></div>
          </xsl:otherwise> 
        </xsl:choose>
       
    </xsl:for-each-group>
  </xsl:template>

  <!-- 
    Department Courses 
    Display all the courses for a given department
  -->
  <xsl:template name="department_courses">

      <!-- Group, itterate, and sort -->     
      <xsl:for-each-group select="course" group-by="department/@code">
        <!-- 
          Check the current department code against the query string params. The query string is 
          split by "=" and pull last item of array. 
        -->
        <xsl:if test="department/@code = $dept_param_seq or department/@code  = replace($dept_param_seq, '%20', ' ')">
          <!-- 
            pdf 
            Provide a link to pdf the curret view.
          -->
          <p class="pdf-view">
            <a href="{$relpath}departments/department.pdf?dept={department/@code}&#38;deptl={encode-for-uri(department/dept_long_name)}">
              <img class="icon" alt="pdf" src="{$relpath}images/pdf.png"/>
            </a>
          </p>
          
          <xsl:sort select="department/@code"/>
          <!--
            Get course navigation
          --> 
          <div class="course_nav">
            <xsl:call-template name="course_navigation"/>
          </div>
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
      <xsl:choose>
        <xsl:when test="$dept_param_seq = ''">  
          <li>  
          <a href="{$relpath}index/home.html">Home</a>    
          </li>
          <li>
          <img class="" alt="arrow" src="{$relpath}images/arrow.gif"/>
          </li> 
          <li class="current">
            Departments
          </li>
      </xsl:when>
      <xsl:otherwise>
        <li>  
        <a href="{$relpath}index/home.html">Home</a>    
        </li>
        <li>
        <img class="" alt="arrow" src="{$relpath}images/arrow.gif"/>
        </li> 
        <li>  
        <a href="{$relpath}department.html">Departments</a>    
        </li>
        <li>
        <img class="" alt="arrow" src="{$relpath}images/arrow.gif"/>
        </li> 
        <li class="current">
        <xsl:value-of select="(//courses/course/department[@code = $dept_param_seq or @code  = replace($dept_param_seq, '%20', ' ')]/dept_short_name)[1]"/>
        </li>
      </xsl:otherwise>
      </xsl:choose>
     </ul>  
  </xsl:template> 

 

</xsl:stylesheet>
