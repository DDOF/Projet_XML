
dtd:
	xmllint --valid --noout master.xml

web:

	xsltproc -o www/master.html xsl/master.xsl master.xml

tidy:

	find -name "*.html" -exec tidy -m -e -q -latin1 {} \;


clean:
	rm -r www/
