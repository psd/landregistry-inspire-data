TARGETS=\
	City_of_London.json

.SUFFIXES:
.SUFFIXES: .zip .gml .json
.PRECIOUS: %.gml

all: $(TARGETS)

# list of files
index.txt:	index.xml
	xsltproc index.xsl $?  | grep '.zip$$' > $@

index.xml:
	wget -q http://data.inspire.landregistry.gov.uk/ -O $@

# process individual GML file
%.zip:
	wget -q http://data.inspire.landregistry.gov.uk/$@ -O $@

%.gml: %.zip
	unzip -qq -c $? Land_Registry_Cadastral_Parcels.gml | sed -e 's/xsi:schemaLocation="[^"]*"//'> $@

%.json: %.gml
	rm -f $@
	ogr2ogr -f "GeoJSON" $@ $<

clean::
	rm -f *.json *.gml *.gfs
