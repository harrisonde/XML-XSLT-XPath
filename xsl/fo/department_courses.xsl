<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:import href="common.xsl"/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="querystring"/>
  <xsl:template match="child::node()">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <!--
         fo:layout-master-set defines in its children the page layout: 
         the pagination and layout specifications
         - page-masters: have the role of describing the intended subdivisions 
         of a page and the geometry of these subdivisions 
         In this case there is only a simple-page-master which defines the 
         layout for all pages of the text
        -->
        <!--  layout information  -->
        <fo:simple-page-master master-name="simple" page-height="11in" page-width="8.5in" margin-top="1.0in" margin-bottom="1.0in" margin-left="1.25in" margin-right="1.25in">
          <fo:region-body margin-top="0.25in"/>
          <fo:region-before extent="0.5in"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <!--  end: defines page layout  -->
      <!--
        start page-sequence here comes the text (contained in flow objects) the page-sequence can contain different fo:flows 
        the attribute value of master-name refers to the page layout which is to be used to layout the text contained in this page-sequence
      -->
      <fo:page-sequence master-reference="simple">
        <!--
         start fo:flow
         each flow is targeted 
         at one (and only one) of the following:
         xsl-region-body (usually: normal text)
         xsl-region-before (usually: header)
         xsl-region-after  (usually: footer)
         xsl-region-start  (usually: left margin) 
         xsl-region-end (usually: right margin) ['usually' applies here to languages with left-right and top-down 
         writing direction like English] in this case there is only one target: xsl-region-body
        -->
        <fo:static-content flow-name="xsl-region-before">
          <!-- Department Name-->
           <fo:block font-size="9pt" font-family="sans-serif" color="black" text-align="right" padding-top="0pt">
             <xsl:value-of select="translate(substring-after(substring-after($querystring, 'deptl'), '='), '20%', ' ')"/>
          </fo:block>
          <!-- Page Numbers -->
          <fo:block font-size="9pt" font-family="sans-serif" color="black" text-align="right" padding-top="1pt">
            Page
            <fo:page-number/>
            <xsl:text> of </xsl:text>
            <fo:page-number-citation ref-id="end"/>
            <xsl:text> </xsl:text>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <!--
            each paragraph is encapsulated in a block element the attributes of the block define font-family and size, 
            line-heigth etc. 
          -->
          <!--  this defines a title  -->
          <fo:block xsl:use-attribute-sets="title">Harvard University, Faculity of Arts &#38; Sciences Course Catalog</fo:block>
          <fo:block xsl:use-attribute-sets="title">
             <xsl:value-of select="translate(substring-after(substring-after($querystring, 'deptl'), '='), '20%', ' ')"/>
          </fo:block>
          <!--  this calls our tempaltes  -->
          <xsl:call-template name="toc"/>
          <xsl:call-template name="department_courses"/>

        </fo:flow>
      <!--  closes the flow element -->
      </fo:page-sequence>
    <!--  closes the page-sequence  -->
    </fo:root>
</xsl:template>

  <!-- Table of contents -->
  <xsl:template name="toc" mode="toc">
    <xsl:for-each select="course">
      <xsl:sort select="title"/>
      <xsl:choose>
        <xsl:when test="contains($querystring, 'cocoon-view=')">
          <xsl:if test="department/@code = substring-after(substring-before($querystring, '&#38;'), '=')">
            <xsl:call-template name="toc_course_list"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
        <xsl:if test="department/@code = substring-after(substring-before($querystring, '&#38;'), '=')">
          <xsl:call-template name="toc_course_list"/>
        </xsl:if> 
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each> 
  </xsl:template>

    <!-- Courses --> 
  <xsl:template name="toc_course_list">
    <fo:block xsl:use-attribute-sets="normal">
      <!-- Title -->
      <fo:basic-link>
        <xsl:attribute name="internal-destination">
          <xsl:value-of select="generate-id()"/>
        </xsl:attribute>
        <!--<xsl:value-of select="current-grouping-key()"/>-->
         <xsl:value-of select="title"/>
      </fo:basic-link>
      <fo:leader leader-pattern="dots"/>
      <!-- Page number of course -->
      <fo:page-number-citation>
        <xsl:attribute name="ref-id">
          <xsl:value-of select="generate-id()"/>
        </xsl:attribute>
      </fo:page-number-citation>
    </fo:block>
  </xsl:template> 

  <!-- Course Detail -->
  <xsl:template name="department_courses" mode="main">
    <xsl:for-each select="course">
      <xsl:sort select="title"/>
      <xsl:choose>
        <xsl:when test="contains($querystring, 'cocoon-view=')">
          <xsl:if test="department/@code = substring-after(substring-before($querystring, '&#38;'), '=')">
            <xsl:call-template name="course_info"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
        <xsl:if test="department/@code = substring-after(substring-before($querystring, '&#38;'), '=')">
          <xsl:call-template name="course_info"/>
        </xsl:if> 
        </xsl:otherwise>
      </xsl:choose>
      <fo:page-number-citation>
<xsl:attribute name="ref-id">
<xsl:value-of select="generate-id()"/>
</xsl:attribute>
</fo:page-number-citation>
    </xsl:for-each> 
    <!--
      This empy block is used to get total number of pages. 
    -->
    <fo:block id="end"/>
  </xsl:template>

  <!-- Course Info  -->
  <xsl:template name="course_info">   
    <!-- Print department name, page number, and total
pages in the document -->
    <fo:block id="{generate-id()}" break-before="page" xsl:use-attribute-sets="title">
      <xsl:value-of select="title"/>
    </fo:block>  
    <fo:block xsl:use-attribute-sets="page">
      <xsl:value-of select="course_group"/>
      <xsl:text>. </xsl:text>
      <xsl:value-of select="course_number/num_int"/>
    </fo:block>        
    <fo:block xsl:use-attribute-sets="page-pad"> 
      <xsl:text>Catalog Number: </xsl:text>
      <xsl:value-of select="@cat_num"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="page">
      <xsl:value-of select="faculty_list"/>
    </fo:block>
    <!-- Logic to echo if is fall or spring class -->
    <xsl:variable name="fall_class" select="term/@fall_term" />
    <xsl:choose>
       <xsl:when test="$fall_class != 'Y'">
        <fo:block xsl:use-attribute-sets="page">
          <xsl:value-of select="credit"/>
         <xsl:text> (spring) </xsl:text>
          <xsl:value-of select="meeting_text"/>
        </fo:block>
       </xsl:when>
       <xsl:otherwise>
        <xsl:value-of select="credit"/>
        <fo:block xsl:use-attribute-sets="page"> 
         <xsl:text> (fall) </xsl:text>
          <xsl:value-of select="meeting_text"/>
        </fo:block>
       </xsl:otherwise>
     </xsl:choose>
    <fo:block xsl:use-attribute-sets="page">
    <xsl:value-of select="course_level"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="page">
    <xsl:value-of select="description"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="page">
    <xsl:value-of select="notes"/>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>