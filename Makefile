
dtd:
	xmllint --valid --noout master.xml

web:

	xsltproc -o www/master.html xsl/master.xsl master.xml

tidy:

	find -name "*.html" -exec tidy -i -m -asxhtml -latin1 "error.txt" {} \;


clean:
	rm -r www/
