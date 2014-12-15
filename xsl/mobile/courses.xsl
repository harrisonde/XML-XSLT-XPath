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
   
  <xsl:template match="//courses">  
      <xsl:call-template name="course_detail"/> 
  </xsl:template>

  <!-- 
    Course detail 
    Display specific course information such as name, number, credit, semerster offered, meeting text, and notes.
  -->
  <xsl:template name="course_detail">
     <div role="tabpanel">
      <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#A" aria-controls="A" role="tab" data-toggle="tab">Course</a></li>
        <li role="presentation"><a href="#B" aria-controls="B" role="tab" data-toggle="tab">Detail</a></li>
      </ul>
      
      <div class="tab-content">

    <xsl:for-each-group select="course[@cat_num = $course_num_param_seq]" group-by="@cat_num">
      <!-- Tab 1-->
      <div role="tabpanel" class="tab-pane active" id="A">
            <h3><xsl:value-of select="title"/></h3>
            <p>
            <a href="{$relpath}{substring-before($url, 'html')}pdf?catnum={@cat_num}&#38;deptl={department/dept_long_name}">
              <img class="icon" height="23" width="23" alt="pdf" src="{$relpath}images/pdf.png"/>
            </a>
          </p>
            <h4>
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
            </h4>
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
            </p>   
          </div>
          <!-- Tab 2-->
          <div role="tabpanel" class="tab-pane" id="B">
              <p>
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
          </div>
  
    </xsl:for-each-group>
  </div>
  </div>
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
          <a href="{$relpath}mobile/index/home.html">Home</a>    
          </li>
          <li>
            /
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
          <a href="{$relpath}mobile/index/home.html">Home</a>    
        </li>
        <li>
          /
        </li>
        <li>  
          Courses    
        </li>
      </xsl:otherwise>
      </xsl:choose>
     </ul>  
  </xsl:template> 
  
</xsl:stylesheet>
