Land Registry INSPIRE polygons from GOV.UK republished as WGS84 geojson/topojson

https://www.gov.uk/inspire-index-polygons-spatial-data

This information is subject to Crown copyright and is reproduced with the permission of Land Registry.
© Crown copyright and database rights 2014 Ordnance Survey 100026316

To rebuild the data:

    $ brew install gdal
    $ brew install xsltproc

    $ npm install -g topojson
    $ make makefiles
    $ make
