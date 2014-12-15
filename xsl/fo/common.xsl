<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:param name="querystring"/>
  <!--
    Common.xsl
      
    Harrison DeStefano
    williamdestefano@harvard.fas.edu

    Define pdf template for common layout, style and structure.
    
    paramaters: (string) dept, (string) deptl
    example: index.pdf?dept=AAAS&deptl=African%20and%20African%20American%20Studies
    usage: xsl:import  
  -->
  <xsl:attribute-set name="page">
    <xsl:attribute name="font-family">Times, serif</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="line-height">16pt</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="space-after.optimum">1pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="page-pad" use-attribute-sets="page">
     <xsl:attribute name="padding-top">5pt</xsl:attribute>
      <xsl:attribute name="padding-bottom">5pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="normal">
    <xsl:attribute name="font-family">Times, serif</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="line-height">15pt</xsl:attribute>
    <xsl:attribute name="space-after.optimum">2pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="title">
    <xsl:attribute name="font-family">Times, serif</xsl:attribute>
    <xsl:attribute name="font-size">18pt</xsl:attribute>
    <xsl:attribute name="line-height">24pt</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="padding-top">16pt</xsl:attribute>
    <xsl:attribute name="space-after.optimum">15pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="title-sub">
    <xsl:attribute name="font-family">Times, serif</xsl:attribute>
    <xsl:attribute name="font-size">16pt</xsl:attribute>
    <xsl:attribute name="line-height">20pt</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="padding-top">15pt</xsl:attribute>
    <xsl:attribute name="space-after.optimum">15pt</xsl:attribute>
  </xsl:attribute-set>
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
           <xsl:call-template name="header"/> 
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <!--  this calls our tempaltes  -->
          <xsl:call-template name="title"/> 
          <xsl:call-template name="toc"/>
          <xsl:call-template name="department_courses"/>

        </fo:flow>
      <!--  closes the flow element -->
      </fo:page-sequence>
    <!--  closes the page-sequence  -->
    </fo:root>
</xsl:template>

  <!-- header -->
  <xsl:template name="header">
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
  </xsl:template>
  
  <!-- title -->
  <xsl:template name="title">
    <fo:block xsl:use-attribute-sets="title">Harvard University, Faculity of Arts &#38; Sciences Course Catalog</fo:block>
  </xsl:template>          

    <!-- Table of contents -->
  <xsl:template name="toc" mode="toc">
    <fo:block xsl:use-attribute-sets="normal">
      <xsl:text>Table of contents</xsl:text>
    </fo:block>
  </xsl:template>

 
  <!-- Course Detail -->
  <xsl:template name="department_courses" mode="main">
      <fo:block xsl:use-attribute-sets="normal">
      <!-- Title -->
      <xsl:text>Course detail</xsl:text>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>