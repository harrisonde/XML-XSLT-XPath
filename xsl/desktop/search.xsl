<?xml version="1.0" encoding="utf-8"?>
  <!--
    Department.xsl
      
    Harrison DeStefano
    williamdestefano@harvard.fas.edu

    Define templates for the department and display related department information.

    usage: map:match 
  -->
  <xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0">

   

  <xsl:import href="common.xsl"/>
  <xsl:param name="relpath"/> 
  <xsl:param name="querystring"/> 
  <xsl:param name="url"/>   
  <!-- Make a sequence of "parameter=value" from the query string -->
  <xsl:variable name="dept_param_seq">
    <xsl:analyze-string select="$querystring" regex="dept=([^&amp;]*)">
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
  <xsl:variable name="inst_param_seq">
    <xsl:analyze-string select="$querystring" regex="inst=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable>
  <xsl:variable name="freetext_param_seq">
    <xsl:analyze-string select="$querystring" regex="ftxt=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable> 
  <xsl:variable name="pagination_param_seq">
    <xsl:analyze-string select="$querystring" regex="pid=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable>
  <xsl:variable name="term_f_param_seq">
    <xsl:analyze-string select="$querystring" regex="fall=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable> 
  <xsl:variable name="term_s_param_seq">
    <xsl:analyze-string select="$querystring" regex="spring=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable> 
  
  <!-- Template -->
  <xsl:template match="//courses">
    <div class="col-xs-3">
      <xsl:call-template name="search_internal_nav"/>
    </div>
    <div class="col-xs-9">
      <!-- Error handling -->
      <xsl:choose>
        <xsl:when test="string-length($querystring) = 0">  
            <h1>Course Search</h1> 
            <hr></hr>
            <xsl:call-template name="search_form"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="search_filter"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  
  </xsl:template>
   <!-- 
    Departments 
    Itterate over data and echo the department name, uri, title, and include a hash on uri to 
    make navigation easy.
    -->
  <xsl:template name="search_internal_nav">
      <h5>Search</h5>
      <!-- 
       We only want unique department short names as short name is used identify 
       what department courses to display in the "list" view. 
       We also use encodes reserved characters in an xs:string that is intended to be used in the 
       path segment of a URI. Adding this just incase we get a joker adding odd things to the 
       model.
        -->
        <ul class="search"> 
          <li>
            <a href="{$relpath}courses/course.html">Courses</a>
          </li> 
          <li>
            <a href="{$relpath}departments/department.html">Departments</a>
          </li>          
        </ul>
  </xsl:template>
  <!-- 
    Navigation 
    Override the default style sheet from common and build main navigtaion
  -->
  <xsl:template name="navigation" match="//course">
    <ul class="breadcrumbs">
      <li>  
        <a href="{$relpath}index/home.html">Home</a>    
      </li>
      <li>
        <img class="" alt="arrow" src="{$relpath}images/arrow.gif"/>
      </li> 
      <!-- Check form status and return correct UI-->
      <xsl:choose>
        <xsl:when test="string-length($querystring) = 0">  
            <li class="current">
              Course Search
            </li>
        </xsl:when>
        <xsl:otherwise>
          <li>
            <a href="{$relpath}search/course.html">Course Search</a>  
          </li>
          <li>
            <img class="" alt="arrow" src="{$relpath}images/arrow.gif"/>
          </li> 
          <li class="current">
            Search Results 
          </li>
        </xsl:otherwise>
      </xsl:choose>
    </ul>  
  </xsl:template> 
  <!-- 
    pdf 
    Provide a link to pdf the curret view.
  -->
  <xsl:template name="pdf">
    <li>
      <a href="{$relpath}{encode-for-uri(substring-before($url, 'html'))}pdf?dept={$dept_param_seq}">
        <img class="icon" alt="pdf" src="{$relpath}images/pdf.png"/>
      </a>
    </li>
  </xsl:template>
  <!-- 
    Search Form 
    The form for searching for a course
  -->
  <xsl:template name="search_form">
    <div class="col-xs-8 col-xs-offset-1">
    <form action="{$relpath}search/course.html" method="GET" class="form-horizontal" role="form">   
      <!-- hidden input fields -->
      <input type="hidden" name="pid" value="1"/>
      <!-- Basic Filters  -->
      <div class="form-group">
        <!-- Departments -->
        <label>Please select a department:
          <select class="form-control" name="dept">
            <option>
              <xsl:attribute name="value"> </xsl:attribute>  
              Any department
            </option>
            <xsl:for-each-group select="//course/department" group-by="@code">
              <xsl:sort select="dept_short_name" />
              <option>
                 <xsl:attribute name="value"><xsl:value-of select="@code"/></xsl:attribute>  
                 <xsl:value-of select="dept_short_name"/>
              </option>
            </xsl:for-each-group>
          </select>
        </label>
      </div>  
      <!-- Advanced Filters -->
      <h2>Advanced Filter</h2>
      <!-- Meeting Day -->
      <div class="form-group">
        <label> Meeting Day:  
          <select class="form-control" name="day">
            <option value="">Any day</option>
            <option value="1">Monday</option>
            <option value="2">Tuesday</option>
            <option value="3">Wednesday</option>
            <option value="4">Thursday</option>
            <option value="5">Friday</option>
            <option value="6">Saturday</option>
            <option value="7">Sunday</option>
          </select> 
        </label>   
      </div>  
      <!-- Meeting Time -->
      <div class="form-group">
        <label> Start Time:  
          <select class="form-control" name="begin_time">
            <option value="">Any time</option>
            <option value="0900">Morning</option>
            <option value="1200">Afternoon</option>
            <option value="1730">Night</option>
          </select> 
        </label>   
      </div>
      <!-- Term -->
      <div class="form-group">
        <p><b>Term</b></p>
        <label> Fall 2014
          <input type="checkbox" name="fall" value="Y"/> 
        </label> 
        <br></br>
        <label> Spring 2015
          <input type="checkbox" name="spring" value="Y"/> 
        </label>    
      </div>
      <!-- Instructor -->
      <div class="form-group">
        <label>Please select a instructor:
          <select class="form-control" name="inst">
            <!-- default option -->
            <option>
                 <xsl:attribute name="value"> </xsl:attribute>  
                 Any instructor
              </option>
            <xsl:for-each-group select="//course/faculty_list/faculty" group-by="@id">
              <xsl:sort select="name/last" />
              <option>
                 <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>  
                 <xsl:value-of select="."/>
              </option>
            </xsl:for-each-group>
          </select>
        </label>
      </div> 
      <!-- Keyword -->
      <div class="form-group">
        <label> Course description keyword:
          <input class="form-control" type="text" name="ftxt"/> 
        </label>   
      </div>
      <!-- Submit this old form, please! -->
      <div class="form-group">
          <button type="submit" class="btn btn-primary">Search</button>
      </div>
    </form>
    </div>
  </xsl:template>
  <!--
    The template for filtering and returning course(s) from querystring.
  -->
  <xsl:template name="search_filter">
    <xsl:variable name="ReturnValue">
      <xsl:call-template name="decode_uri">
        <xsl:with-param name="encoded_uri_string" select="$freetext_param_seq"/>
      </xsl:call-template>  
    </xsl:variable>
    <!-- Disply keyword searches -->
    <xsl:choose>
      <xsl:when test="string-length($freetext_param_seq) &#62;= 1">
       <h2>Search Results:
        <span class="search-text">
          <xsl:value-of select="$ReturnValue"/>
        </span>
       </h2>
      </xsl:when>
      <xsl:otherwise>
        <h2>Search Results:</h2>
      </xsl:otherwise>
    </xsl:choose>
    <!-- 
      Filter for coruse(s) by querystring paramaters. Check the lenght of said
      querystring paramater, if not passed 0 otherwise filter said paramater.
    -->
    <xsl:variable name="course_results" select="//course[
      ((string-length($dept_param_seq) = 0) or $dept_param_seq = department/@code)
      and
      ((string-length($day_param_seq) = 0) or $day_param_seq = schedule/meeting/@day)
      and
      ((string-length($begin_time_param_seq) = 0) or $begin_time_param_seq &#60;= schedule/meeting/@begin_time)
      and
      ((string-length($inst_param_seq) = 0) or $inst_param_seq = faculty_list/faculty/@id)
      and
      ((string-length($freetext_param_seq) = 0) or lower-case(.)[contains(., lower-case(translate($ReturnValue, '+' , ' ')))] )
      and
      ((string-length($term_f_param_seq) = 0) or $term_f_param_seq = term/@fall_term)
      and
      ((string-length($term_s_param_seq) = 0) or $term_s_param_seq = term/@spring_term)
     ]"  />
    <xsl:variable name="number_of_courses" select="count($course_results)"/>
    <xsl:variable name="show_per_page" select="450" /> 
    <xsl:variable name="number_of_pages" select="xs:integer(ceiling( $number_of_courses div $show_per_page ))" /> 

    <xsl:variable name="current_page" select="$pagination_param_seq" /> 
    <xsl:for-each-group select="$course_results" group-by=".">
      <xsl:sort select="course_group/@code"/>
      <xsl:sort  select="course_number/num_int"/>
         <!-- pagination -->
        <xsl:if test="position() = 1"> 
          <!-- Results -->
          <ul class="pagination pagination-sm">
            <xsl:for-each select="1 to $number_of_pages">
              <xsl:variable name="current_position" select="position()" />
              <xsl:variable name="clean_querystring" select="substring-before($querystring, 'pid=')" />
              <!-- Previous navigation element -->
              <xsl:if test="position() = 1">
                <xsl:choose> 
                <xsl:when test="($current_page - 1) &#62; 0"> 
                  <xsl:variable name="clean_querystring" select="substring-before($querystring, 'pid=')" />
                  <xsl:variable name="prev_position" select="$current_page - 1" />      
                  <li>
                    <a href="{$relpath}search/course.html?{$clean_querystring}pid={$prev_position}">
                      <span>&#60;&#60;</span>
                      <span class="sr-only">Previous</span>
                    </a>
                  </li>
                </xsl:when>
                <xsl:otherwise>
                  <li class="disabled">
                    <a class="disabled" href="#">
                      <span>&#60;&#60;</span>
                      <span class="sr-only">Previous</span>
                    </a>
                  </li>
                </xsl:otherwise> 
              </xsl:choose>  
              </xsl:if>  
              <!-- Pagination Elements -->
              <xsl:choose>
                <xsl:when test="$current_position = $current_page">
                  <li class="active">
                    <a class="active" href="{$relpath}search/course.html?{$clean_querystring}pid={$current_position}">
                      <xsl:value-of select="$current_position"/>
                    </a>
                  </li>
                </xsl:when>
                <xsl:otherwise>
                  <li>
                    <a href="{$relpath}search/course.html?{$clean_querystring}pid={$current_position}">
                      <xsl:value-of select="$current_position"/>
                    </a>
                  </li>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            <!-- Pagination Next--> 
            <xsl:choose>
              <xsl:when test="($current_page + 1) &#60; $number_of_pages"> 
                <xsl:variable name="clean_querystring" select="substring-before($querystring, 'pid=')" />
                <xsl:variable name="next_position" select="$current_page + 1" />      
                <li>
                  <a href="{$relpath}search/course.html?{$clean_querystring}pid={$next_position}">
                    <span>&#62;&#62;</span>
                    <span class="sr-only">Next</span>
                  </a>
                </li>
              </xsl:when>
              <xsl:otherwise>
                <li class="disabled">
                  <a class="disabled" href="#">
                    <span>&#62;&#62;</span>
                    <span class="sr-only">Next</span>
                  </a>
                </li>
              </xsl:otherwise> 
            </xsl:choose> 
          </ul> 
          <p>
            Showing <xsl:value-of select="$current_page"/> of <xsl:value-of select="$number_of_pages"/> page(s).
          </p>  
          <hr></hr>  
          <ul class="nav nav-pills search-pils" role="tablist">
            <li role="presentation">Course(s) <span class="badge"><xsl:value-of select="$number_of_courses"/></span></li>
          </ul>   
        </xsl:if>   
        <!-- 
          Coruse link(s) show only if within a specific range 

            Simple algorithm for range:
            range_max = $show_per_page * current_page
            range_min = $range_max - $show_per_page
        -->
        <xsl:variable name="range_max" select="$show_per_page * $current_page" />
        <xsl:variable name="range_min" select="$range_max - $show_per_page" />
         <!--               1      <=   max                     1      >=   min      -->
        <xsl:if test="position() &#60;= $range_max and position() &#62;= $range_min">  
          <a class="search-result-link" href="{$relpath}courses/course.html?catnum={@cat_num}" title="{title}">
            <xsl:value-of select="course_group/@code"/>
            <xsl:value-of select="course_number/num_int"/>
            -
            <xsl:value-of select="title"/>
          </a>
        </xsl:if>   
    </xsl:for-each-group>
    <!-- Display link to return and rest search form -->
    <hr></hr>
    <a href="{$relpath}search/course.html" class="btn btn-default course-search">Clear results</a>
  </xsl:template>  
</xsl:stylesheet>
