# ARCH 5115 (Dietzsch) - QGIS Workshop, Day 2

Workshop 2021-09-07 by Keith Jenkins, GIS Librarian at Mann Library

For help after this workshop, contact me at kgj2@cornell.edu  
Or set up a Zoom appointment at <https://guides.library.cornell.edu/gis/help>

All the data and documentation for this workshop can be downloaded from: \
<https://github.com/kgjenkins/arch-5115-xingu/archive/main.zip>

* Unzip the files


## Elevation raster data

Various scales of elevation data is available for different parts of the world.  Some places like Ithaca, NY may have 1- or 2-meter resolution data available from a local lidar survey.  But for much of the world, the best available is 30-meter SRTM data, collected as part of the Shuttle Radar Topography Mission in 2000.

Due to the large size of these elevation datasets, downloads are divided into smaller tiles.  SRTM data is available in 1x1 degree tiles.  There are various ways of accessing this data, including the "SRTM Downloader" plugin for QGIS, which makes it fairly easy to download all the tiles needed for a given area.  Downloading the data requires registering for a free NASA EarthData login, but four data tiles have already been downloaded for you.  Raster data comes in many different formats -- GeoTIFF (.tif) is very common, but the SRTM tiles are in a custom .hgt format.

* Select all the .hgt files in the "data/elevation" folder and drag them onto your QGIS map.

Notice that each tile has a slightly different min/max range, which causes abrupt changes along adjacent tile edges.  To combine all the tiles into a single, seamless layer, we will create a virtual raster:

* Raster menu > Miscellaneous > Build Virtual Raster...
* For "Input layers", click the "..." button, select all the .hgt files, then click "OK"
* Under "Virtual", click the "..." button, and select "Save to file"
* Save it as "elevation.vrt" in the same folder where the .dem files are located
* Click "Run"

Now you should have a seamless mosaic of the elevation data.  You can now remove the original files from your project, but don't delete them from your folder! (because the .vrt points out to those files)

* In the QGIS Layers panel, select all the .hgt layers, then right-click > Remove Layer...

By default, raster data is displayed with a gray gradient, with higher values brighter.  We can change the style to bring out more details in the data.

* In the Layer Styling panel, change from "Singleband gray" to "Singleband pseudocolor"
* Try changing the color ramp to "Turbo"


## Value Tool plugin

Although we could use the "Identify" tool to click pixels and see their values, the "Value Tool" plugin will allow you to instantly show the values from raster layers without even having to click.

* Plugins > Manage and Install Plugins...
* Search all plugins for "value tool" and install it

The Value Tool will appear on your toolbar as a green circle with white "i".

* Click the Value Tool button to open the panel
* Check the box to enable the tool
* Move your cursor across the map to view the raster values

Try checking the elevations in different parts of the map.  Note that the SRTM elevations are in meters (not feet), and due to the way the data was collected (from space), it tends to represent the elevation of the tops of the trees, not the ground.  As a consequence, you can see a drop in elevation in areas where the forest has been clear-cut.


## Elevation hillshade

Even though we can see structure of the levees and streets with the color ramp, it still looks rather flat.  Let's use a hillshade to made it look more 3-dimensional.

* In the Layers Panel, right-click the elevation layer > Duplicate
* Right-click "elevation copy" > Rename to "hillshade"
* Move the "hillshade" layer just above "elevation" and check the box to display the hillshade layer
* Open the styling panel be sure that you are styling the "hillshade" layer
* Change "Singleband pseudocolor" to "Hillshade"
* Set the blending mode to "multiply" (which will let us also see the colorized version underneath)
* Set to Z Factor to 0.0001 (to adjust for the fact that our horizontal units are degrees and vertical units are meters)
* Try turning the dial to adjust the angle of the "sun"


## Creating contour lines

There is a "contours" display style for rasters, but is just a visual effect.  If we want to export 3D contour lines for use in a program like Rhino or AutoCAD, we will need to create a vector contour layer.

Creating contours for the entire "elevation" layer (which contains over 324 million pixels) would take several minutes (especially with the unevenness of the SRTM data), so for demonstration purposes, we will first clip the raster to a small area of interest.

* Zoom to the south-central part of the raster, around Canarana (toggle layers as needed to see where you are)
* Open the processing toolbox (gear icon, or in the Processing menu)
* Search for and open the "Clip raster by extent" tool
* Input layer = elevation
* For the clipping extent, click the '...' to draw on canvas (drag a rectangle over the area to clip)
* Leave the other settings and click "Run"

This will create a new, temporary layer called "Clipped (extent)" that we can use for generating contours:

* Open the processing toolbox (gear icon, or in the Processing menu)
* Search for "contour" and open the "Contour" tool under GDAL > Raster extraction
* Set the following parameters:
  * Input layer = "Clipped (extent)"
  * Interval between contour lines = 10m (not a good idea to go any smaller given the 30m pixel size)
  * Check the box to "Produce 3D vector" (if you don't see it, expand the Advanced Parameters section)
* Keep the other options and click "Run"

To export the 3D contours to DXF, right-click the layer > Export > Save features as ... AutoCAD DXF or else export your whole project to DXF.  Be sure to use a CRS that uses meters (to match the vertical elevation units), such as "EPSG:26918 = NAD83 / UTM zone 22S (meters)".


## Landcover

Landcover data attempts to identify the predominant type of land cover (water, forest, grass, developed, etc.) either by polygon or as a raster dataset.  In this case, we will use [Esri 2020 Land Cover](https://www.arcgis.com/home/item.html?id=d6642f8a4f6d4685a24ae2dc0c73d4ac), a global dataset that just released this year, created using a deep learning model and Sentinel-2 satellite imagery.  Data downloaded via the [Esri 2020 Land Cover Downloader](https://arcgis.com/home/item.html?id=fc92d38533d440078f17678ebc20e8e2), but a sample has already been downloaded for you.

* Load the data from "data/esri-2020-landcover/landcover-sample.tif"

This is a categorical raster, and the numeric values of each pixel refers to a specific landcover category.  The colors are defined in the raster, but the names of the landcover categories are not included.  But we can add them.

* Open the README.txt file to see the values 1-10 and what landcover type they represent.
* In the layer styling panel, add those names to the label for each category.
* Select and delete the styles for values 11 and higher (they are not used)

This style information is only saved in the QGIS project file (.qgz), but you can also export it to a style file for easy re-use.  It has already been saved for you -- here's how to load it:

* Double-click the layer name to open the layer properties
* Go to the Symbology tab on the left
* At the bottom left, click the "Style" button > Load style...
* Select and open the esri-landcover-style.qml file

Similarly, you would use "Save style..."  to export such a file.



## Other satellite imagery

In addition to the aerial imagery available via the Bing, Google, etc. basemaps, it is also possible to acquire satellite imagery for specific dates.  There are numerous satellites that are orbiting the planet and collecting data on a regular schedule.  For example, Landsat covers most of the planet every 14 days.  Some images are too cloudly for use, but you can usually find an good image within a couple months of a specific year.  Sentinel-2 is another popular imagery satellite -- it is operated by the European Space Agency, which makes many of its data products freely available.

* Explore the various .tif files in the "data/sentinel" folder
* Use the Value Tool to view the values of these rasters

These samples were downloaded using [Sentinel Hub's EO Browser](https://apps.sentinel-hub.com/eo-browser/) where you can search and preview images in your browser.  Several versions of each image are available, such as true color, false color (infrared), NDVI (vegetation index), moisture index, NDWI (water index), and more.  Each of these derived products were designed to help identify specific things on the ground.

If you want to download GeoTIFF files for use with GIS software, you'll need to register for a free login.
