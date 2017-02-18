<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:output method="html" encoding="iso-8859-1" indent="yes" doctype-system="master.dtd"/>
	<xsl:template match="/">
		<html>
			<head><title>Index</title>

		</head>
		<body>
			
			<xsl:call-template name="menu"/>

		</body></html>
		<xsl:for-each select="//parcours">

			<xsl:result-document href="parcours/{@id}.html">
				<xsl:call-template name="menu">
					<xsl:with-param name="sub" select="'../'" />
				</xsl:call-template>
				<h2><xsl:value-of select="nom" /></h2>
				
				<xsl:value-of select="responsable" />
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="débouchés"/>
				<ul><xsl:for-each select="semestre">
					<li><xsl:value-of select="@numero" /></li>
					<ul>
						<xsl:for-each select="role">
							<li><xsl:value-of select="@type"/></li>
							<ul>
								<xsl:for-each select="ref_unite">

									<li><a><xsl:attribute name="href">../unites/<xsl:value-of select="@ref" />.html</xsl:attribute><xsl:value-of select="text()"/></a></li>
								</xsl:for-each>
							</ul>
						</xsl:for-each></ul>

					</xsl:for-each></ul>
				</xsl:result-document>
			</xsl:for-each>

			<xsl:for-each select="//intervenant">

				<xsl:result-document href="int/{@id}.html">
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
	</xsl:result-document>
</xsl:for-each>

<xsl:for-each select="//unite">

	<xsl:result-document href="unites/{@id}.html">
		<xsl:call-template name="menu">
			<xsl:with-param name="sub" select="'../'" />
		</xsl:call-template>
		<div><xsl:attribute name="id"><xsl:value-of select="@id" />
	</xsl:attribute>
	<h2><xsl:value-of select="nom" /></h2></div>
	<li> Credit : <xsl:value-of select="credit" /></li>
	<li> Description : <xsl:apply-templates select="resume"/></li>
	<xsl:variable name="ref" select="ref_intervenant"/>
	<li> Responsable : <a><xsl:attribute name="href">../intervenants.html#<xsl:value-of select="ref_intervenant" /></xsl:attribute>

	<xsl:value-of select="../intervenant[@id=$ref]/nom" /></a></li>
	<xsl:variable name="id" select="@id"/>

	<ul>
		<p> Cet UE figure dans les parcours suivants :</p>
		<xsl:for-each select="//ref_unite[@ref = $id]">

			<li><a><xsl:attribute name="href">../parcours/<xsl:value-of select="../../../@id" />.html</xsl:attribute>
			<xsl:value-of select="../../../nom"/>
		</a></li>
	</xsl:for-each>
</ul>
</xsl:result-document>
</xsl:for-each>

<xsl:result-document href="intervenants.html">

	<html>
		<head><title>Intervenants</title></head>
		<body>
			<xsl:call-template name="menu"/>
			<xsl:call-template name="liste-des-intervenants" />
		</body>
	</html>
</xsl:result-document>
<xsl:result-document href="parcours.html">
	
	<html>
		<head><title>Parcours</title></head>
		<body>
			<xsl:call-template name="menu"/>
			<xsl:call-template name="liste-des-Parcours" />
		</body>
	</html>
</xsl:result-document>
<xsl:result-document href="unites.html">
	<html>
		<head><title>Unites</title></head>
		<body>

			<xsl:call-template name="menu"/>

			<div id="contenu">
				<xsl:call-template name="liste-des-unites" />
			</div>
		</body>
	</html>
</xsl:result-document>
</xsl:template>

<xsl:template name="liste-des-unites">
	<h1> Liste des Unités</h1>

	<xsl:for-each select="//unite"><ul>
		<li><xsl:attribute name="id"><xsl:value-of select="@id" />
	</xsl:attribute>
	<a><xsl:attribute name="href">unites/<xsl:value-of select="@id" />.html</xsl:attribute><xsl:value-of select="nom" /> </a>

</li>
<li>Crédit : <xsl:value-of select="credit" /></li>
<li>
	<xsl:apply-templates select="resume"/>
</li>
<xsl:variable name="ref" select="ref_intervenant"/>
<li> Responsable : <a><xsl:attribute name="href">int/<xsl:value-of select="ref_intervenant" />.html</xsl:attribute>

<xsl:value-of select="../intervenant[@id=$ref]/nom" /></a></li>
</ul>
</xsl:for-each>

</xsl:template>


<xsl:template name="liste-des-intervenants">
	<h1> Liste des intervenants</h1>
	<xsl:for-each select="//intervenant"><ul>
		<xsl:attribute name="id"><xsl:value-of select="@id" />
	</xsl:attribute><li>
	<a><xsl:attribute name="href">int/<xsl:value-of select="@id" />.html</xsl:attribute><xsl:value-of select="nom" /></a>
</li>

<li>
	<xsl:value-of select="mail" />
</li>
</ul>
</xsl:for-each>

</xsl:template>	
<xsl:template name="liste-des-Parcours">
	<h1> Liste des Parcours</h1>
	<xsl:for-each select="//parcours"><ul>
		<xsl:attribute name="id"><xsl:value-of select="@id" />
	</xsl:attribute><li>
	<a><xsl:attribute name="href">parcours/<xsl:value-of select="@id" />.html</xsl:attribute><xsl:value-of select="nom" /></a>
</li>

</ul>
</xsl:for-each>

</xsl:template>	
<xsl:template name="menu">
	<xsl:param name="sub" />
	<div id="entete">
		<h2> Master Informatique de Marseille</h2>
	</div>

	<link rel="stylesheet" type="text/css" href="{$sub}css/monStyle.css"/>
	<ul id="menu">
		<li><a href="{$sub}index.html">Index</a></li>
		<li><a href="{$sub}intervenants.html">Intervenants</a></li>
		<li><a href="{$sub}unites.html">Unites</a></li>
		<li><a href="{$sub}parcours.html">Parcours</a></li>
		<li><a href="{$sub}xq.html">Xquery</a></li>

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
<xsl:template match="list">
	<li>
		<xsl:value-of select="."/>
	</li>
</xsl:template>
</xsl:stylesheet>
