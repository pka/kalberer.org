+++
title = "Equal Earth OpenLayers sprint in Graz"
taxonomies.tags = ["equalearth", "projections"]
+++

After my initial work on using the [Equal Earth map projection](https://www.equal-earth.com/) in web mapping during my sabbatical in 2024, it was time
for implementing extensions to web mapping libraries for a seamless integration of Equal Earth in interactive maps.


<!-- more -->

<img src="../assets/equal-earth-etopo1.jpg" width="70%"/>

After discussions at the FOSSGIS conference in Münster with Andreas Hocevar, one of the lead developers of OpenLayers, we found time for a 4 day autumn code sprint in Graz. My plan was to start with a raster tile implementation, using OpenLayers' raster reprojection support and then go into reprojection support for Vector tiles.

## Day 1

<img src="../assets/ee-sprint-nightjet.jpg" width="70%"/>

Using the direct night train from Sargans to Graz, I've joined Andreas in his office Wednesday morning, ready to start.

In the afternoon I had an interactive map in Equal Earth projection based on a WGS84 raster tile service.

The new approach, using a source in WGS84 (aka geographic, equirectangular or plate carrée) projection proved feasible, but a few important parts were still missing. OpenLayers draws a map also outside of the projection area, so the next goal was to render a mask layer to hide these redundant outside parts. But after fighting hours with projection calculations at the antimeridian, I gave up for now.

![](../assets/ee-sprint-raster-reprojection.png)

## Day 2

As a next step, we moved on to a vector tile implementation and analyzed the code path where reprojection of vector tiles should be done. This proved to be way more complicated than I expected and I had to hand over my plan to implement this to Andreas.

My next part was an experimental implementation of OpenLayers support for projection functions in addition to static projections. With Andreas' help I was able to build a partially working prototype, but it looked like an endless endeavour to fix all parts of OpenLayers where a static projection was assumed. So we decided to go back to the previous implementation, which updates the OpenLayers view on panning events.

## Day 3

After working with raster tiles and initial experiments with vector tiles, I've started a new OL example, reprojecting a thematic map with a GeoJSON vector data source. GeoJSON uses geographic (WGS84) coordinates, which is a good starting point for Equal Earth or other projections. The first steps went well, but soon after changing the center meridian, the first ugly rendering glitches appeared.

To find out whether Proj4js was the guilty party, I've tested the same GeoJSON with QGIS, which uses Proj as projection library.

![](../assets/ee-sprint-qgis.png)

Since Proj4js is a Javascript port of PROJ, having the same glitches with QGIS didn't tell us whether the projection library itself causes these artifacts, or both rendering engines have problems with geometries crossing the antimeridian in non-rectangular projections.

As a next step, we've experimented with the projection functions of [D3](https://d3js.org/), which seems to be more robust in rendering GeoJSON data in different projections. But after a good hour of trying to understand how D3 handles projections, we decided to end the experiment and to add a preprocessing step of splitting geometries at the current antimeridian instead. Using clipping functions from Turf this didn't require many lines of code, but produced a few invalid geometries which either ended in holes or new rendering artifacts.

## Day 4

Having a movable map with only a few glitches left, we concentrated on making the dynamic reprojection smoother when panning the map.
We've ended up at 5° projection steps based on the change:center event of the view.

![](../assets/ee-sprint-screens.jpg)

Andreas was able to show WGS84 tiles reprojected to Web-Mercator. This doesn't look very impressive, but is a major step for supporting other display projections. Unlike Web-Mercator, Equal Earth has non-rectangular bounds and therefore also distorts the rectangular source tile grid. There will be difficulties at the projection border and additional clipping at the projected tile borders may be needed. Andreas plans to work on this the coming weekend, let's see how far he will get!

<img src="../assets/ee-sprint-beer.jpg" width="70%"/>

After a last beer I've entered my train back to Switzerland, with the plan to replace Turf clipping with clamping coordinates at the projection boundaries and making the example ready for a pull request.

So hopefully, our code will be public soon and then it's time to think about the next steps.
