#
#  build topojson files for Land Registy INSPIRE index polygons
#
.SUFFIXES:
.SUFFIXES: .zip .gml .geojson
.PRECIOUS: .zip %.geojson
.PHONY: makefiles

-include makefiles/polygons.mk

all: $(TARGETS)

# download an individual zip file
%.zip:
	wget -q http://data.inspire.landregistry.gov.uk/$@ -O $@

# extract the GML shapefile
data/%.gml: data/%.zip
	unzip -qq -c $? Land_Registry_Cadastral_Parcels.gml | sed -e 's/xsi:schemaLocation="[^"]*"//'> $@

# create geojson with WSG84 coordinates from GML shapefile
polygons/%.geojson: data/%.gml
	rm -f $@
	mkdir -p polygons
	ogr2ogr  -t_srs WGS84 -f "GeoJSON" $@ $<

# create topojson from  geojson
polygons/%.topojson: polygons/%.geojson
	topojson $< > $@

clean::
	rm -f data/*.gml data/*.gfs

clobber::
	rm -f index.txt index.xml polygons/*

# bootstrap makefile targets from index
makefiles:	makefiles/polygons.mk

makefiles/polygons.mk:	index.txt
	@mkdir -p makefiles
	echo 'TARGETS=\\' > $@
	sed -e 's:^:polygons/:' -e 's/.zip/.topojson \\/' index.txt >> $@
	echo index.txt >> $@

# index of shapefiles from a directory listing
index.txt:	index.xml
	xsltproc index.xsl $?  | grep '.zip$$' > $@

index.xml:
	wget -q http://data.inspire.landregistry.gov.uk/ -O $@
