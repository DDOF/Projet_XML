<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
	<xsl:output method="html" encoding="iso-8859-1" indent="yes" doctype-system="master.dtd"/>
<xsl:template match="/">
    <html><body>
       <xsl:call-template name="liste-des-unites" />
       <xsl:call-template name="liste-des-intervenants" />
    </body></html>
  </xsl:template>

  <xsl:template name="liste-des-unites">
    <h1> Liste des Unités</h1>
    <ul>
    <xsl:for-each select="//unite"><li>
      <div><xsl:attribute name="id"><xsl:value-of select="@id" />
      </xsl:attribute>
        <xsl:value-of select="nom" /> </div>
     <xsl:value-of select="credit" />
      <xsl:value-of select="string(resume)" />
      <a><xsl:attribute name="href">#<xsl:value-of select="ref_intervenant/@ref" />
      </xsl:attribute>
        <xsl:value-of select="ref_intervenant/@ref" /> </a>
    </li>
</xsl:for-each>
  </ul>
  </xsl:template>


<xsl:template name="liste-des-intervenants">
  <h1> Liste des intervenants</h1>
    <ul>
    <xsl:for-each select="//intervenant"><li>
      <div><xsl:attribute name="id"><xsl:value-of select="@id" />
      </xsl:attribute>
        <h2><xsl:value-of select="nom" /> </h2></div>
     <xsl:value-of select="mail" />
   </li>
     </xsl:for-each>
   </ul>
  </xsl:template>

<xsl:template match="intervenant">

<ul></ul>
</xsl:template>

</xsl:stylesheet>
