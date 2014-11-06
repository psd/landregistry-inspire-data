.SUFFIXES:
.SUFFIXES: .zip .gml .geojson
.PRECIOUS: .zip %.geojson
.PHONY: makefiles

-include makefiles/polygons.mk

all: $(TARGETS)

# list of files
index.txt:	index.xml
	xsltproc index.xsl $?  | grep '.zip$$' > $@

index.xml:
	wget -q http://data.inspire.landregistry.gov.uk/ -O $@

# process individual GML file
%.zip:
	wget -q http://data.inspire.landregistry.gov.uk/$@ -O $@

data/%.gml: data/%.zip
	unzip -qq -c $? Land_Registry_Cadastral_Parcels.gml | sed -e 's/xsi:schemaLocation="[^"]*"//'> $@

polygons/%.geojson: data/%.gml
	rm -f $@
	mkdir -p polygons
	ogr2ogr  -t_srs WGS84 -f "GeoJSON" $@ $<

polygons/%.topojson: polygons/%.geojson
	topojson $< > $@

clean::
	rm -f *.geojson *.gml *.gfs

makefiles:	makefiles/polygons.mk

makefiles/polygons.mk:	index.txt
	@mkdir -p makefiles
	echo 'TARGETS=\\' > $@
	sed -e 's:^:polygons/:' -e 's/.zip/.topojson \\/' index.txt >> $@
	echo index.txt >> $@
