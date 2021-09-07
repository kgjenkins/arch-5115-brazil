<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis hasScaleBasedVisibilityFlag="0" styleCategories="AllStyleCategories" minScale="1e+08" version="3.20.2-Odense" maxScale="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <temporal enabled="0" mode="0" fetchMode="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <customproperties>
    <Option type="Map">
      <Option value="false" type="bool" name="WMSBackgroundLayer"/>
      <Option value="false" type="bool" name="WMSPublishDataSourceUrl"/>
      <Option value="0" type="int" name="embeddedWidgets/count"/>
      <Option value="Value" type="QString" name="identify/format"/>
    </Option>
  </customproperties>
  <pipe>
    <provider>
      <resampling zoomedOutResamplingMethod="nearestNeighbour" enabled="false" zoomedInResamplingMethod="nearestNeighbour" maxOversampling="2"/>
    </provider>
    <rasterrenderer opacity="1" alphaBand="-1" band="1" nodataColor="" type="paletted">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <colorPalette>
        <paletteEntry value="0" alpha="0" color="#000000" label="0"/>
        <paletteEntry value="1" alpha="255" color="#419bdf" label="1 Water"/>
        <paletteEntry value="2" alpha="255" color="#397d49" label="2 Trees"/>
        <paletteEntry value="3" alpha="255" color="#88b053" label="3 Grass"/>
        <paletteEntry value="4" alpha="255" color="#7a87c6" label="4 Flooded vegetation"/>
        <paletteEntry value="5" alpha="255" color="#e49635" label="5 Crops"/>
        <paletteEntry value="6" alpha="255" color="#dfc35a" label="6 Scrub/shrub"/>
        <paletteEntry value="7" alpha="255" color="#c4281b" label="7 Built Area"/>
        <paletteEntry value="8" alpha="255" color="#a59b8f" label="8 Bare ground"/>
        <paletteEntry value="9" alpha="255" color="#a8ebff" label="9 Snow/ice"/>
        <paletteEntry value="10" alpha="255" color="#616161" label="10 Clouds"/>
      </colorPalette>
      <colorramp type="randomcolors" name="[source]">
        <Option/>
      </colorramp>
    </rasterrenderer>
    <brightnesscontrast gamma="1" contrast="0" brightness="0"/>
    <huesaturation colorizeOn="0" colorizeBlue="128" grayscaleMode="0" colorizeGreen="128" colorizeRed="255" saturation="0" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
