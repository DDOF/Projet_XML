all : dtd web tidy

dtd:
	xmllint --valid --noout master.xml

web:
	mkdir -p www
	xsltproc -o www/index.html xsl/master.xsl master.xml

tidy:

	find -name "*.html" -exec tidy -i -q -m -asxhtml {} \;

clean:
	rm -r www/
