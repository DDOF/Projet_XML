dtd:
	xmllint --valid --noout master.xml

web:

	xsltproc -o www/master.html xsl/master.xsl master.xml
