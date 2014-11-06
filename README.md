Land Registry INSPIRE polygons from GOV.UK republished as topojson

    https://www.gov.uk/inspire-index-polygons-spatial-data

    This information is subject to Crown copyright and is reproduced with the permission of Land Registry.
    © Crown copyright and database rights 2014 Ordnance Survey 100026316

To rebuild the data:

    $ sudo apt-get install gdal-bin xsltproc
    $ sudo npm install -g topojson

or 

    $ brew install gdal xsltproc
    $ npm install -g topojson

then

    $ make makefiles
    $ make
