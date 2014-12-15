<?xml version="1.0" encoding="utf-8"?>
  <!--
    Departments_json.xsl
      
    Harrison DeStefano
    williamdestefano@harvard.fas.edu

    Itterate over a collection of course data and return departments that contain char match. The
    compare aims to be case insensitive.

    usage: map:match 
  -->
  <xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:param name="querystring"/> 

  <xsl:template match="/">
    [
      <xsl:for-each-group select="//course[ contains( lower-case(department), lower-case(substring-after($querystring, 'q=') ) ) ]" group-by="department">
      <xsl:sort select="department/dept_short_name"/>
      {
      "department":"<xsl:value-of select="distinct-values(replace(department/dept_short_name, '&#34;', ' '))"/>", <!-- Removing quote(s) from department title -->
      "uri": "<xsl:text>department.html?dept=</xsl:text><xsl:value-of select="encode-for-uri(department/@code)"/>"
      }
      <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>


    </xsl:for-each-group>
    ]
  </xsl:template>
</xsl:stylesheet>