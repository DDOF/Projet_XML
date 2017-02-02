<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" encoding="iso-8859-1" indent="yes" doctype-system="master.dtd"/>
	<xsl:template match="/">
		<html>
			<head><title>Index</title></head>
			<body>
				<xsl:call-template name="menu"/>
			</body></html>
			<xsl:for-each select="//parcours">

				<xsl:document href="parcours/{nom}.html">
					<xsl:call-template name="menu">
						<xsl:with-param name="sub" select="'../'" />
					</xsl:call-template>
					<h2><xsl:value-of select="nom" /></h2>
					<xsl:apply-templates select="description"/>

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
				<xsl:call-template name="menu">
					<xsl:with-param name="sub" select="'../'" />
				</xsl:call-template>
				<div><xsl:attribute name="id"><xsl:value-of select="@id" />
			</xsl:attribute>
			<h2><xsl:value-of select="nom" /></h2></div>
			<xsl:value-of select="mail" />
			<xsl:variable name="id" select="@id"/>
			<ul>
				<xsl:for-each select="//unite/ref_intervenant">
					<xsl:if test="@ref = $id">
						<li><a><xsl:attribute name="href">../unites/<xsl:value-of select="../@id" />.html</xsl:attribute>
						<xsl:value-of select="../nom"/></a></li>
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
		<xsl:call-template name="menu">
			<xsl:with-param name="sub" select="'../'" />
		</xsl:call-template>
		<div><xsl:attribute name="id"><xsl:value-of select="@id" />
	</xsl:attribute>
	<h2><xsl:value-of select="nom" /></h2></div>
	<xsl:value-of select="credit" />
	<xsl:apply-templates select="resume"/>
	<a><xsl:attribute name="href">../intervenants.html#<xsl:value-of select="ref_intervenant/@ref" />
</xsl:attribute>
<xsl:value-of select="ref_intervenant/@ref" /></a>
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
	<xsl:call-template name="menu"/>
	<html>
		<head><title>Intervenants</title></head>
		<body>
			<xsl:call-template name="liste-des-intervenants" />
		</body>
	</html>
</xsl:document>
<xsl:document href="unites.html">
	<xsl:call-template name="menu"/>
	<html>
		<head><title>Unites</title></head>
		<body>
			<xsl:call-template name="liste-des-unites" />
		</body>
	</html>
</xsl:document>
</xsl:template>

<xsl:template name="liste-des-unites">
	<h1> Liste des Unités</h1>

	<xsl:for-each select="//unite"><ul>
		<li><xsl:attribute name="id"><xsl:value-of select="@id" />
	</xsl:attribute>
	<a><xsl:attribute name="href">unites/<xsl:value-of select="@id" />.html</xsl:attribute><xsl:value-of select="nom" /> </a>

</li>
<li><xsl:value-of select="credit" /></li>
<li>
	<xsl:apply-templates select="resume"/>
</li>
<li><a><xsl:attribute name="href">intervenants.html#<xsl:value-of select="ref_intervenant/@ref" />
</xsl:attribute>
<xsl:value-of select="ref_intervenant/@ref" /></a>
</li></ul>
</xsl:for-each>

</xsl:template>


<xsl:template name="liste-des-intervenants">
	<h1> Liste des intervenants</h1>
	<xsl:for-each select="//intervenant"><ul>
		<xsl:attribute name="id"><xsl:value-of select="@id" />
	</xsl:attribute><li>
	<a><xsl:attribute name="href">int/<xsl:value-of select="nom" />.html</xsl:attribute><xsl:value-of select="nom" /></a>
</li>

<li>
	<xsl:value-of select="mail" />
</li>
</ul>
</xsl:for-each>

</xsl:template>	
<xsl:template name="menu">
	<xsl:param name="sub"   />
	<ul>
		<li><a href="{$sub}master.html"> Index</a></li>
		<li><a href="{$sub}intervenants.html"> Intervenants</a></li>
		<li><a href="{$sub}unites.html"> Unites</a></li>

	</ul>
</xsl:template>
<xsl:template match="i">
	<i>
		<xsl:value-of select="."/>
	</i>
</xsl:template>
<xsl:template match="par">
	<p>
		<xsl:value-of select="."/>
	</p>
</xsl:template>
<xsl:template match="bold">
	<strong>
		<xsl:value-of select="."/>
	</strong>
</xsl:template>
</xsl:stylesheet>
