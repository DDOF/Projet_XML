<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   version="1.0">

   <xsl:output method="xml" encoding="iso-8859-1" indent="yes" doctype-system="master.dtd"/>

   <xsl:template match="/">
      <master>
                  <xsl:for-each select="//objet[@type = 'programme']">
            <parcours>
                  <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
               <responsable>
                  <xsl:variable name="ref" select="info[@nom='responsables']/@value"/>

                  <xsl:value-of select="../objet[@type = 'personne'and @id=$ref]/info[@nom='prenom']/@value" />

                  &#160;
                  <xsl:value-of select="../objet[@type = 'personne'and @id=$ref]/info[@nom='nom']/@value" />
               </responsable>
               <nom><xsl:value-of select="info[@nom='nom']/@value"/></nom>
               <description></description>
               <débouchés></débouchés>
               
                  <xsl:call-template name="semestre"/>
               
            </parcours>
         </xsl:for-each>

                  <xsl:for-each select="//objet[@type = 'personne']">
            <intervenant>
               <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
                  <nom><xsl:value-of select="info[@nom='prenom']/@value"/>
                  &#160;<xsl:value-of select="info[@nom='nom']/@value"/></nom>
                  <mail><xsl:value-of select="info[@nom='mail']/@value"/></mail>

            </intervenant>
         </xsl:for-each>
         <xsl:for-each select="//objet[@type = 'enseignement']">
            <unite>
               <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
               <nom><xsl:value-of select="info[@nom='nom']/@value"/></nom>
               <credit><xsl:value-of select="info[@nom='nb_credits']/@value"/></credit>
               <resume><xsl:apply-templates select="info[@nom='contenu']"/></resume>
               <plan></plan>
               <lieu></lieu>
               <ref_intervenant><xsl:value-of select="info[@nom='responsables']/@value"/></ref_intervenant>
            </unite>
         </xsl:for-each>
   </master>
   </xsl:template>
   <xsl:template name="semestre" >

      <xsl:for-each select="info[@nom='structure']">
         <semestre>

         <xsl:variable name="id-sem" select="@value"/>
         <xsl:attribute name="numero"><xsl:value-of select="../../objet[@type='semestre' and @id=$id-sem]/info[@nom='nom']/@value" />
         </xsl:attribute>
                     <xsl:value-of select="$id-sem"/>
         <role type="obligatoires">
         

         
      <xsl:for-each select="../../objet[@type='semestre' and @id=$id-sem]/info[@nom='structure']">
         
         <xsl:variable name="id-ens" select="@value"/>
         <xsl:if test="../../objet[@type = 'enseignement'and @id=$id-ens]">
         <ref_unite>
            <xsl:attribute name="ref"><xsl:value-of select="$id-ens" />
         </xsl:attribute>
          <xsl:value-of select="../../objet[@type = 'enseignement'and @id=$id-ens]/info[@nom='nom']/@value" />
            
         </ref_unite>
      </xsl:if>
      </xsl:for-each>

   </role>
   <role type="options">
      <xsl:for-each select="../../objet[@type='semestre' and @id=$id-sem]/info[@nom='structure']">
         
         <xsl:variable name="id-ens" select="@value"/>
         <xsl:if test="not(../../objet[@type = 'enseignement' and @id=$id-ens])">
            <xsl:variable name="sub-ens" select="@value"/>
         <xsl:for-each select="../../objet[@id=$sub-ens]/info[@nom='structure']">

         <ref_unite>
            <xsl:variable name="temp" select="@value"/>
            <xsl:attribute name="ref"><xsl:value-of select="@value" />
            
         </xsl:attribute>
                   <xsl:value-of select="../../objet[@type = 'enseignement' and @id=$temp]/info[@nom='nom']/@value" />
            
         </ref_unite>
      </xsl:for-each>
      </xsl:if>
      </xsl:for-each>
   </role>

</semestre>
   </xsl:for-each>
   </xsl:template>
   <xsl:template select="t">
      <list>
         <xsl:value-of select="."/>
      </list>

   </xsl:template>
      <xsl:template select="p">
      <par>
         <xsl:value-of select="."/>
      </par>

   </xsl:template>

</xsl:stylesheet>
