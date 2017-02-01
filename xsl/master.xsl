<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
	<xsl:output method="html" encoding="iso-8859-1" indent="yes" doctype-system="master.dtd"/>
<xsl:template match="/">
    <html>
        <head><title>Index</title></head>
    <body>

    </body></html>
     <xsl:for-each select="//parcours">

        <xsl:document href="parcours/{nom}.html">
    <h2><xsl:value-of select="nom" /></h2>
<xsl:value-of select="description" />
<xsl:value-of select="débouchés" />
 <ul><xsl:for-each select="semestre">
<li><xsl:value-of select="@numero" /></li>
<ul>
<xsl:for-each select="role">
<li><xsl:value-of select="@type"/></li>
    <ul>
    <xsl:for-each select="ref_unite">
    
      <li><a><xsl:attribute name="href">../unites/<xsl:value-of select="@ref" />.html
      </xsl:attribute>
<xsl:value-of select="text()"/>         
</a></li>
     </xsl:for-each>
     </ul>
     </xsl:for-each></ul>

     </xsl:for-each></ul>
    </xsl:document>
     </xsl:for-each>

    <xsl:for-each select="//intervenant">

        <xsl:document href="int/{nom}.html">
      <div><xsl:attribute name="id"><xsl:value-of select="@id" />
      </xsl:attribute>
        <h2><xsl:value-of select="nom" /> </h2></div>
     <xsl:value-of select="mail" />
     <xsl:variable name="id" select="@id"/>

     <ul>
     <xsl:for-each select="//unite/ref_intervenant">
        <xsl:if test="@ref = $id">
             <li><a><xsl:attribute name="href">../unites/<xsl:value-of select="../@id" />.html
      </xsl:attribute>
      <xsl:value-of select="../nom"/>
    </a></li>
      </xsl:if>
     </xsl:for-each>
   </ul>
                <xsl:variable name="nom" select="nom"/>

     <ul>
     <xsl:for-each select="//parcours">
        <xsl:if test="responsable = $nom">
             <li><a><xsl:attribute name="href">../parcours/<xsl:value-of select="//parcours/nom" />.html
      </xsl:attribute>
      <xsl:value-of select="//parcours/nom"/>
    </a></li>
      </xsl:if>
     </xsl:for-each>
   </ul>
    </xsl:document>
     </xsl:for-each>

    <xsl:for-each select="//unite">

        <xsl:document href="unites/{@id}.html">
           <div><xsl:attribute name="id"><xsl:value-of select="@id" />
      </xsl:attribute>
        <h2><xsl:value-of select="nom" /></h2></div>
     <xsl:value-of select="credit" />
      <xsl:value-of select="string(resume)" />
      <a><xsl:attribute name="href">../intervenants.html#<xsl:value-of select="ref_intervenant/@ref" />
      </xsl:attribute>
        <xsl:value-of select="ref_intervenant/@ref" /> </a>
             <xsl:variable name="id" select="@id"/>

     <ul>
     <xsl:for-each select="//parcours//ref_unite">
        <xsl:if test="@ref = $id">
             <li><a><xsl:attribute name="href">../parcours/<xsl:value-of select="//parcours/nom" />.html
      </xsl:attribute>
      <xsl:value-of select="//parcours/nom"/>
    </a></li>
      </xsl:if>
     </xsl:for-each>
   </ul>
    </xsl:document>
     </xsl:for-each>

      <xsl:document href="intervenants.html">
        <html>
          <head><title>Intervenants</title></head>
          <body>
              <xsl:call-template name="liste-des-intervenants" />
          </body>
        </html>
      </xsl:document>
<xsl:document href="unites.html">
        <html>
          <head><title>Intervenants</title></head>
          <body>
              <xsl:call-template name="liste-des-unites" />
          </body>
        </html>
      </xsl:document>
  </xsl:template>

  <xsl:template name="liste-des-unites">
    <h1> Liste des Unités</h1>
    
    <xsl:for-each select="//unite"><ul>
      <div><xsl:attribute name="id"><xsl:value-of select="@id" />
      </xsl:attribute>
            <li><a><xsl:attribute name="href">unites/<xsl:value-of select="@id" />.html</xsl:attribute>
        <h2><xsl:value-of select="nom" /> </h2></a></li>
        </div>
     <li><xsl:value-of select="credit" /></li>
      <li><xsl:value-of select="string(resume)" /></li>
      <li><a><xsl:attribute name="href">intervenants.html#<xsl:value-of select="ref_intervenant/@ref" />
      </xsl:attribute>
        <xsl:value-of select="ref_intervenant/@ref" /> </a>
    </li></ul>
</xsl:for-each>
  
  </xsl:template>


<xsl:template name="liste-des-intervenants">
  <h1> Liste des intervenants</h1>
    <xsl:for-each select="//intervenant"><ul>
      <xsl:attribute name="id"><xsl:value-of select="@id" />
      </xsl:attribute><li>
            <a><xsl:attribute name="href">int/<xsl:value-of select="nom" />.html</xsl:attribute>
        <h2><xsl:value-of select="nom" /> </h2></a></li>
        
    <li>
     <xsl:value-of select="mail" />
   </li>
 </ul>
     </xsl:for-each>
   
  </xsl:template>

<xsl:template match="intervenant">

</xsl:template>

</xsl:stylesheet>
