.PHONY: java clean all
all : dtd web tidy java

dtd:
	#Parse les données du master et validation avec notre dtd
	xsltproc -o data.xml xsl/parser.xsl data/donnees-master.xml
	tidy -i -q -m -xml data.xml
	xmllint --valid --noout data.xml

web:
	mkdir -p www
	mkdir -p www/css/
	cp monStyle.css www/css
	xsltproc -o www/index.html xsl/master.xsl data.xml

tidy:

	find -name "*.html" -exec tidy --show-warnings no -i -q -m -asxhtml -utf8 {} \;
clean:
	rm -r www/

java:
	java -classpath "java/" Unites
