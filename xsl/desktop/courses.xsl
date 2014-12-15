<?xml version="1.0" encoding="utf-8"?>
<!--
    courses.xsl
      
    Harrison DeStefano
    williamdestefano@harvard.fas.edu

    Define templates for the displaying course data.

    usage: map:match  
  -->
<xsl:stylesheet  xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
 <xsl:import href="common.xsl"/>
  <xsl:param name="cat_num" />
  <xsl:param name="relpath"/>
  <xsl:param name="querystring"/> 
  <!-- Make a sequence of "parameter=value" from the query string -->
   <xsl:variable name="course_num_param_seq">
    <xsl:analyze-string select="$querystring" regex="catnum=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable> 
   <xsl:variable name="day_param_seq">
    <xsl:analyze-string select="$querystring" regex="day=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable>
   <xsl:variable name="begin_time_param_seq">
    <xsl:analyze-string select="$querystring" regex="begin_time=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable> 

  <xsl:template match="//courses">  
      <xsl:choose>
        <!-- direct browsing display search link and text -->
        <xsl:when test="$course_num_param_seq != ''">
           <xsl:call-template name="course_detail"/>
        </xsl:when> 
         <!-- course by day-->
        <xsl:when test="string-length($course_num_param_seq) = 0
          and
            string-length($day_param_seq) > 0
          or
             string-length($begin_time_param_seq) > 0
          ">
            <xsl:call-template name="department_courses"/>
        </xsl:when> 
        <xsl:otherwise>
          <!-- 
              The following language is taken from http://www.extension.harvard.edu/courses
              and is the property of Harvard University.
            -->
            <h1>On-campus and Online Courses</h1> 
            <p>You’ve got a goal, a drive, a passion. We’ve got over 600 courses to choose from. Courses are offered online or on campus at Harvard. If you have the determination, we have the options—no application required.</p>
            <a href="{$relpath}search/course.html" class="btn btn-primary center-block course-search">Search for a course</a>
            <h2>In the classroom, online, or hybrid</h2> 
            <p>We offer courses on campus in the evenings, as well as online video courses, web-conference courses, and hybrid options. Learn about the course formats.</p>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  <!-- 
    Department Courses 
    Display all the courses for a given department
  -->
  <xsl:template name="department_courses">
    <!-- Display the searh type (day or time) -->
    <xsl:choose>
      <xsl:when test="string-length($day_param_seq) > 0">
        <h2>Displaying courses by day:
          <xsl:choose>
            <xsl:when test="$day_param_seq = 1">
               <span class="search-text">Monday</span>
            </xsl:when>
            <xsl:when test="$day_param_seq = 2">
              <span class="search-text">Tuesday</span>
            </xsl:when>
            <xsl:when test="$day_param_seq = 3">
               <span class="search-text">Wednesday</span>
            </xsl:when>
            <xsl:when test="$day_param_seq = 4">
               <span class="search-text">Thursday</span>
            </xsl:when>
            <xsl:when test="$day_param_seq = 5">
               <span class="search-text">Friday</span>
            </xsl:when>
            <xsl:when test="$day_param_seq = 6">
               <span class="search-text">Saturday</span>
            </xsl:when>
             <xsl:otherwise>
              <span class="search-text">Sunday</span>
            </xsl:otherwise>
          </xsl:choose>
        </h2>
      </xsl:when>
      <xsl:otherwise>
        <h2>Displaying courses by time:
          <xsl:choose>
            <xsl:when test="$begin_time_param_seq &#60;= 1130">
               <span class="search-text">Morning</span>
            </xsl:when>
            <xsl:when test="$begin_time_param_seq &#62;= 1130 and $begin_time_param_seq &#60;= 1630">
              <span class="search-text">Afternoon</span>
            </xsl:when>
            <xsl:when test="$begin_time_param_seq &#62; 1630">
               <span class="search-text">Night</span>
            </xsl:when>
             <xsl:otherwise>
              <span class="search-text">Other</span>
            </xsl:otherwise>
          </xsl:choose>
        </h2>
      </xsl:otherwise>
    </xsl:choose>
      <!-- Group, itterate, and sort -->     
      <xsl:for-each-group select="course[
        ((string-length($day_param_seq) = 0) or $day_param_seq = schedule/meeting/@day)
        and
      ((string-length($begin_time_param_seq) = 0) or schedule/meeting/@begin_time &#60;= $begin_time_param_seq)
        ]" 
        group-by="department/@code">
        <!-- 
          Check the current department code against the query string params. The query string is 
          split by "=" and pull last item of array. 
        -->
          <xsl:sort select="department/@code"/>
          <!--
            Get course navigation
          --> 
            <xsl:call-template name="course_navigation"/>
          <!--
            Get department/course data
          -->
          <xsl:call-template name="department_course_data"/>  

      </xsl:for-each-group> 
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
            <a href="courses/course.html?{$querystring}#{course_group/@code}">  
              <xsl:value-of select="course_group"/> 
            </a>
            <span> | </span>
          </xsl:when>
          <xsl:when test="position() != 1 and position() = last()">
            <a href="courses/course.html?{$querystring}#{course_group/@code}">  
              <xsl:value-of select="course_group"/>
            </a>
          </xsl:when>
        </xsl:choose>
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
        <table class="table table-striped table-bordered courses">
          <tr>
            <th>Day/Time</th>
            <th>Number</th>
            <th>Term</th>
            <th>Title</th>
          </tr> 
          <xsl:for-each select="current-group()">
            <xsl:sort select="course_number/num_int"/>
            <!-- course day, time, title, number, and uri -->
            <tr>
              <td class="day-time">
                <!-- 
                  Covert numerical day indicator to that of the human
                  readable string value 
                -->
                <xsl:for-each-group select="schedule/meeting/@day" group-by=".">
                  <xsl:variable name="converted_day" select="
                  if (. = 1) then
                  'M'
                  else if (. = 2) then
                  'T'
                  else if (. = 3) then
                  'W'
                  else if (. = 4) then
                  'Th'
                  else if (. = 5) then
                  'F'
                  else if (. = 6) then
                  'Sat'
                  else
                  'Sun'
                  "/> 
                  <xsl:value-of select="$converted_day"/>
                  <xsl:text> </xsl:text>
                </xsl:for-each-group> 

                 <br></br> 
                <!-- Start Time -->
                <xsl:for-each-group select="schedule/meeting/@begin_time" group-by=".">
                  <xsl:value-of select="."/>
                  <br/>
                </xsl:for-each-group> 
              </td>
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
    Course detail 
    Display specific course information such as name, number, credit, semerster offered, meeting text, and notes.
  -->
  <xsl:template name="course_detail">
    <xsl:for-each-group select="course" group-by="@cat_num">
        <xsl:if test="@cat_num = $course_num_param_seq">
            <p class="pdf-view">
              <a href="{$relpath}{substring-before($url, 'html')}pdf?catnum={@cat_num}&#38;deptl={department/dept_long_name}">
                <img class="icon" alt="pdf" src="{$relpath}images/pdf.png"/>
              </a>
            </p>
            <h2><xsl:value-of select="title"/></h2>
            <h3>
              <!--
                Print * if instructor approval required
              -->
              <xsl:variable name="approval_req" select="instructor_approval_required"/>
              <xsl:if test="compare($approval_req, 'Y') != -1">
                  <text>*</text>
              </xsl:if> 
              <xsl:value-of select="course_group"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="course_number/num_int"/>
              <xsl:text>.</xsl:text>
            </h3>
            <p>Catalog Number: <xsl:value-of select="@cat_num"/></p>
            <p><i><xsl:value-of select="faculty_list"/></i></p>
            <p>
              <xsl:value-of select="credit"/>
              <!-- Logic to echo if is fall or spring class -->
              <xsl:variable name="fall_class" select="term/@fall_term" />
              <xsl:choose>
                 <xsl:when test="$fall_class != 'Y'">
                   <xsl:text> (spring) </xsl:text>
                 </xsl:when>
                 <xsl:otherwise>
                   <xsl:text> (fall) </xsl:text>
                 </xsl:otherwise>
               </xsl:choose>
              <xsl:value-of select="meeting_text"/>
            </p>
            <p>
              <xsl:value-of select="course_level"/>
            </p>
            <p>
              <xsl:value-of select="description"/>
            </p>
            <p>
              <xsl:value-of select="notes"/>
            </p>
        </xsl:if>
    </xsl:for-each-group>
  </xsl:template>

  <!-- 
    Course-internal-nav
    Template to display internal navigation within courses
  -->
  <xsl:template name="course-internal-nav">
       <h5>Courses</h5>
        <ul class="course-options">
          <li>
            <a href="{$relpath}search/course.html">Course Search</a>
          </li>
        </ul>
  </xsl:template>

  <!-- 
    Navigation 
    Override the default style sheet from common and build main navigtaion
  -->
  <xsl:template name="navigation">
    <ul class="breadcrumbs">
      <xsl:choose>
        <xsl:when test="$course_num_param_seq = ''">  
          <li>  
          <a href="{$relpath}index/home.html">Home</a>    
          </li>
          <li>
          <img class="" alt="arrow" src="{$relpath}images/arrow.gif"/>
          </li> 
          <li class="current">
            Courses
          </li>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable
          name="department_link"
          select="//courses/course[@cat_num = $course_num_param_seq]/department/@code">
        </xsl:variable>  
        <li>  
          <a href="{$relpath}index/home.html">Home</a>    
        </li>
        <li>
          <img alt="arrow" src="{$relpath}images/arrow.gif"/>
        </li>
        <li>  
          <a href="{$relpath}courses/course.html">Course</a>    
        </li>
        <li>
          <img alt="arrow" src="{$relpath}images/arrow.gif"/>
        </li>
        <li>
          <a href="{$relpath}departments/department.html?dept={$department_link}" title="">
            <xsl:value-of select="(//courses/course[@cat_num = $course_num_param_seq]/department/dept_short_name)"/>
          </a>  
        </li>
        <li>
            <img alt="arrow" src="{$relpath}images/arrow.gif"/>
        </li> 
        <li class="current">
          <!-- Parse super long titles -->
          <xsl:variable
            name="department_title"
            select="//courses/course[@cat_num = $course_num_param_seq]/title">
          </xsl:variable>  
          <xsl:choose>
            <xsl:when test="string-length($department_title) > 40">
              <xsl:value-of select="concat(substring($department_title, 1, 40), '...')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$department_title"/>
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </xsl:otherwise>
      </xsl:choose>
     </ul>  
  </xsl:template> 
  
</xsl:stylesheet>
