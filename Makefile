TARGETS=\
	City_of_London.topojson


.SUFFIXES:
.SUFFIXES: .zip .gml .geojson
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

%.geojson: %.gml
	rm -f $@
	ogr2ogr  -t_srs WGS84 -f "GeoJSON" $@ $<

%.topojson: %.geojson
	topojson $< > $@

clean::
	rm -f *.geojson *.gml *.gfs
