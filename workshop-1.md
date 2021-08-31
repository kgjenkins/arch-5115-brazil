# ARCH 5115 (Dietzsch) - QGIS Workshop, Day 1

Workshop 2021-08-31 by Keith Jenkins, GIS Librarian at Mann Library

For help after this workshop, contact me at kgj2@cornell.edu  
Or set up a Zoom appointment at <https://guides.library.cornell.edu/gis/help>

All the data and documentation for this workshop can be downloaded from:  
<https://github.com/kgjenkins/arch-5115-xingu/archive/main.zip>


## Some GIS Concepts

**GIS** stands for Geographic Information System (or Science)

"GIS data" refers to data with a spatial component -- it can be mapped!

**QGIS** (<https://qgis.org/>) is one of several popular GIS programs for mapping and spatial analysis.  It is free, open-source desktop software that runs on Windows, Mac, and Linux.  QGIS is created by developers around the world, supported by municipal and national governments, corporations, user groups, and individual users.  Discussions about new features, bug fixes, and future directions happen on [e-mail lists](https://qgis.org/en/site/getinvolved/mailinglists.html) and the [project's GitHub organization](https://github.com/qgis).

Questions about how to use QGIS are typically asked and answered on [GIS StackExchange](https://gis.stackexchange.com/).  If you google for QGIS questions, there is a good chance you'll end up finding the answer already there, so always be sure to search before asking a new question.

**Vector** = points, lines, polygons
Common file formats are GeoPackage (.gpkg) and Shapefile (.shp, .dbf, .prj, etc.)

**Raster** = pixels (images, but also data)
Common file format is GeoTIFF (.tif)

Vector data does not usually contain any information about how to style the display of the data.

Styles are added in a map project.  The same data could be styled in different ways in different maps, or even in the same map!

The QGIS project file .qgz contains your styles and pointers to the data, but does not include the data itself.  I recommend keeping everything within a containing folder (there can be subfolders) that you can zip up or save to a device or the cloud.  Something like this:

* myproject/
  * data/
    * boundaries/
      * counties.gpkg
      * states.gpkg
    * buildings.gpkg
    * streets.shp
  * notes-about-sources.txt
  * mymap.qgz

**CRS** = Coordinate Reference System

Ideally, CRS details are quietly handled behind the scenes, so we barely even need to think about it.

But in the real world, you'll eventually run into CRS puzzles and problems, and CRS becomes even more important when doing distance- or area-based analysis.  Here are some of the CRS you might see in western NY:

* EPSG:4326 = WGS 84 -- "common longitude/latitude"
* EPSG:4989 = SIRGAS 2000 -- longitude/latitude, similar to WGS 84, but based on a model of the Earth only defined for South and Central America
* EPSG:3857 = WGS 84 / Pseudo-Mercator -- also called "Web Mercator", uses false "meters" (only true at equator)
* EPSG:31892 = SIRGAS 2000 / UTM zone 22S (meters)


## State and Municipality Boundaries

Load the GADM administrative boundaries for Brazil:
* Look in the "gadm-boundaries" folder and drag the "gadm36_BRA.gpkg" file onto the QGIS window

This is a geopackage that contains 4 different layers: country, state, municipality, etc.  
* Select all the layers and make sure "add layers to a group" is checked.
* Expand the "gadm36_BRA" group in the layers panel
* Toggle the different layers to explore the differences

Change the layer style of level 1 (states):
* toggle the other layers off
* Click "gadm36_BRA_1" to select it
* Open the Layer Styling panel – colorful paintbrush icon at top left of the Layers panel
* Change the color
* Click "Simple fill" to change other properties, like stroke color and width

Get information about a polygon:
* Click "Identify Features" tool, select the layer, then click a polygon

View information about all the polygons as a table:
* Right-click layer in Layers pane > Open Attribute Table
* Click on a column header to sort by that column

The table and map are linked, so select 'Mato Grosso' from the table (by clicking the row number) to see it highlighted in yellow on the map.  There is a toolbar button to "Deselect features from all layers".

Add labels by clicking the label tab (yellow "abc") in the styling panel
* Single Labels, value = NAME_1
* 9 tabs of options!
* 1st tab (text) - font, size, color
* 2nd tab (formatting) - wrap lines to 12 characters

To find out what CRS (coordinate reference system) is being used:
* Right-click > Properties...  Source tab


## Save your project!

Save "mymap.qgz" to the folder that also contains your data -- for example, within the "QGIS-workshops" folder. That way, you can zip up or move the containing folder around while keeping your map and data intact. The .qgz project file contains your map styles and pointers to your data files, but not the data itself.


## Streets

OpenStreetMap is a great source of streets data, and is widely considered to be the most complete and accurate street map in the world.  Data for Brazil has been clipped to the Mato Grosso and saved in a shapefile format, which is probably the most common geospatial data format found on the Internet, but the shapefile format dates from the early 1990s, which is why there are multiple component files (.shp, .dbf, .shx, .prj, and sometimes others).  To add a shapefile to QGIS, we just need to select the .shp file and QGIS will take care of the rest.  Shapefiles also have other quirks, mostly notably a 10-character limit for attribute names.  Learn more at <http://switchfromshapefile.org/>

* Look in the 'openstreetmap' folder, and drag the "osm-roads.shp" file onto QGIS
* If it ends up in the GADM group, drag it up above in the list of layers

Explore the data a bit (identify tool, attribute table), and notice the contents of the "fclass" column -- click the header twice to reverse sort by this column.  It has values like 'trunk', 'primary', 'secondary', 'path', etc.  The definitions of these values can be found on the [OpenStreetMap wiki](https://wiki.openstreetmap.org/wiki/Key:highway#Highway)

We can use those values to control the layer style and give prominence to the interstates and state highways.

* At the top of the layer styling panel, change "Single symbol" to "Categorized"
* Set Value = "fclass", then click the "Classify" button towards the bottom of the panel

Random colors are assigned to each of the values, which is not really what we want.  You can shift-click to select all the symbols, then right-click to change the color for all the values at once.
* Change all the road colors to black
* Ctrl-click to select just the 'motorway', 'primary', and 'secondary' symbols
* Right-click > Change width to 0.7mm

Try turning on labels for the streets (using the "label" field) and zooming in and out a bit.
* PRO-TIP: Use Ctrl-scroll to zoom more slowly with more control

There are many options that can be configured to improve the appearance of the labels, but it can require a lot of work and even manual adjustments to make it look really good, so...
* Turn off your road labels, since we'll use a basemap instead.


## Basemaps via QuickMapServices

Basemaps are web-based map images designed by professional cartographers who have already done the hard work of aggregating different data layers and customizing styles and labels to work at different zoom levels.  Basemaps are usually global in scope, although there are some that only focus on certain regions.  They can be used to add context to your map, or just to help confirm that your data is correctly aligned.  The QuickMapServices plugin makes this easy, but we need to install it first.

* Plugins menu > Manage and Install Plugins...
* Scroll down, or search all plugins for "quickmap" (you don’t need to type the whole name)
* Select the QuickMapServices plugin
* Click the "Install plugin" button (it installs in seconds)
* Click "Close"

When you first install QuickMapServices, you'll want to get the full set of basemap definitions.

* Web menu > QuickMapServices > Settings
* "More services" tab > "Get contributed pack"

To add the Google Hybrid basemap, which combines aerial photos with placename labels:

* Web menu > QuickMapServices > Google > Google Hybrid

Most basemaps are in a different projection (CRS) called Pseudo- or Web-Mercator, EPSG:3857.  QGIS is reprojecting it to match the CRS of the first dataset we loaded, which can cause some pixelation, making the labels hard to read.  If you zoom out, you'll notice that the US looks stretched out.

To avoid the pixelization and the stretched shapes, we can set our map to use the basemap CRS:
* Right-click the Google layer > Set CRS > Set Project CRS from Layer
* Right-click the Google layer > Zoom to Native Resolution (100%)

Turn the streets layer back on, and explore how well it aligns with the imagery.

Turn on the "gadm36_BRA_1" layer, and adjust the style to work better with the basemap:
* Click "Simple fill", then set fill style = No Brush
* Set the stroke color to orange, width = 2mm

As we add more data, it may help to use a cartographic basemap:
* Web menu > QuickMapServices > OSMStamen > OSM Standard
* Uncheck the Google Hybrid layer to hide it
* Adjust the other layer styles as needed (white buffer, for example)

The Stamen Toner Lite layer is very light, so we can add our own streets on top if we want to emphasize the full road network.
* In the streets style panel, adjust Layer Rendering > Opacity to control the visual weight of the streets


## Indigenous Areas

To focus on 'Parque do Xingu', we'll want to have a layer containing the boundary.  Fortunately, the Brazilian government has a dataset of indigenous areas that includes Xingu.

* Add the shapefile from the 'terrabrasilis/indigeneous_area_legal_amazon' folder
* Open the attribute table

Notice that there are some text encoding problems.  This is because the text-encoding type was not defined in the shapefile (geopackage handles this better).  But we can fix it in QGIS:

* Double-click the layer name to open the Properties
* Go to the "Source" tab on the left
* Set the "Data source encoding" to "UTF-8" and click "OK"

Re-open the attribute table, and hopefully the accents and other diacritics now show properly.

Notice that there are many different polygons covering much of the Amazon.  We can select the polygon(s) we want and save them to a separate file.

* Zoom in to the area near Xingu
* Click the "Select Features by area or single click" tool in the toolbar (the 1st of three yellowing icons in a row)
* Click the "indigeneous_area..." layer name, then drag a rectangle to select the polygons you want (you can also ctrl-click to toggle individual polygons on/off)
* Right-click the layer name > Export > Save selected features as...
* Set Format = GeoPackage
* Don't just type in a file name! as we don't quite know where it would be saved!  Always click the '...' button to browse to where you want to save the file.  In this case, save it to the 'data' folder as 'xingu.gpkg'
* Ignore the other options, and click 'OK' to save.


## Inverted Polygons to mask surrounding areas

One last trick, to set the focus of our map on Xingu, will be to mask the areas outside the city.  The "inverted polygon" option will apply a style to the outside (rather than the inside) of a polygon.
* Click the 'xingu' layer
* In the styling panel, change "Single symbol" to "Inverted polygons"
* Click "Simple fill" and set the fill style to "Solid"
* Set the Fill color and Stroke color to white
* Click "Fill" to get to the option for setting the feature opacity, setting it around 65%


## Explore other datasets

The 'data' folder contains several other datasets that have been compiled for this workshop.  If we have time, we'll take a few minutes to explore those datasets.  OpenStreetMap is a major source of various types of data: streets, building footprints, points of commerce or tourism, schools, hospitals, railroads, waterways, and nearly everything else that can be mapped.  Where the data exists, it is usually of high quality, but not everything has been mapped.  Just because you find a bus stop point in one part of a city doesn't necessarily mean that all bus stops in that city have been mapped.  In some cases, OSM may have it's own version of features that are also available from other sources, including official government sources.  In other cases, there is no official open data, and OSM may be the best option.

Try opening both versions of the following municipal boundaries datasets and compare them, zooming in to look at the geometry as well comparing the attributes:
* terrabrasilis/municipalities_legal_amazon
* gadm36_BRA_2

How similar are the boundaries How are they different?


## Exporting your map to an image file

To export the current map view to an image file:
* Project menu > Import/Export > Export Map to Image...
* Update the extent or leave as is
* Increase the resolution (try 300dpi)
* Save as a .png file


## Exporting your map to a PDF file

Exporting to PDF is useful if you are going to print your map, or if you want to do further work in a program like Inkscape or Adobe Illustrator.  The PDF will keep separate layers for each data layer.  Vector layers will remain vectors, and raster layers will remain raster.

* Project menu > Import/Export > Export Map to PDF...
* Check the settings, especially the resolution if your map includes raster layers, including basemaps


## Exporting data layers to a DXF file (for CAD software)

Architects often want to export GIS layers for use in a CAD program like Rhino or AutoCAD.  Since DXF is a vector format, only vector layers can be exported -- sorry, no basemaps!  When exporting to CAD, be sure to set an appropriate CRS for the exported data, which means a CRS based on meters or feet -- not degrees longitude/latitude.
* Project menu > Import/Export > Export Project to DXF...
* Click the "..." button to specify where to save the .dxf file
* Be sure to select an appropriate CRS!  QGIS will reproject all your layers to the chosen CRS.  A good CRS options for Xingu is:
  * EPSG:26918 = NAD83 / UTM zone 22S (meters)

Don't export to DXF using any of these CRS, or you will see distortions and incorrect measurements:
* EPSG:4326 = WGS 84 -- "common longitude/latitude"
* EPSG:4269 = NAD83 -- longitude/latitude, similar to WGS 84, but only defined for North America
* EPSG:3857 = WGS 84 / Pseudo-Mercator -- also called "Web Mercator", uses false "meters" (only true at equator)

If you have data that extends beyond your area of interest, and don't want to export it all to DXF, try checking the "Export features intersecting the current map extent".  (You may need to cancel if you need to adjust the map extent, and then open the export dialog again.)



## Coming next... on QGIS Workshop Day 2

* elevation data - pseudocolor, hillshades, and contours
* landcover
