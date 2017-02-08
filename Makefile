.PHONY: java clean all
all : dtd xsd web tidy

dtd:
	#Parse les données du master et validation avec notre dtd
	xsltproc -o master.xml xsl/parser.xsl data/donnees-master.xml
	tidy -i -q -m -xml master.xml
	xmllint --valid --noout master.xml

xsd: 
	xmllint --noout --schema master.xsd master.xml
web:
	mkdir -p www
	mkdir -p www/css/
	cp monStyle.css www/css
	xsltproc -o www/index.html xsl/master.xsl master.xml

tidy:

	find -name "*.html" -exec tidy --show-warnings no -i -q -m -asxhtml -utf8 {} \;
xq:
	java -cp "saxon9he.jar" net.sf.saxon.Query -s:"master.xml" -q:"xq.txt" -o:"www/xq.html"
clean:
	rm -r www/

java:
	java -classpath "java/" Unites
