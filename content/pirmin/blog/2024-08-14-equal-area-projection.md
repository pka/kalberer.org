+++
title = "Equal Earth projection for web mapping"
taxonomies.tags = ["equalearth", "projections"]
+++

As a follow-up to the State of the Map Europe presentation, this article shows the current
state of the proof-of-concept implementation using an Equal Earth projection in web mapping.

<!-- more -->

## Goodbye Web Mercator

At the State of the Map Europe 2024 conference in Łódź I've presented the results of my studies to replace Web Mercator in world maps. The main problem, its size distortion, is well known. 

![](../assets/mercator-size-distortion-animated.gif)

Africa actually has 14 times as much area as Greenland!

The [slides](https://pka.github.io/farewell-web-mercator/) of the talk are available online.

## Equal Earth projection for web mapping

<img src="../assets/equal-earth-etopo1.jpg" width="70%"/>

The [Equal Earth map projection](https://www.equal-earth.com/) is my choice to replace Web Mercator for world maps. It is an equal-area projection, published in 2018 by Bojan Šavrič, Tom Patterson and Bernhard Jenny.

By using the projection with a dynamic center meridian, Equal Earth could also be a replacement for Web Mercator on higher zoom levels. But generating static tiles with dynamic projections is technically difficult. So I've presented a demo combining Equal Earth at zoom levels 0-2 and Web Mercator at zoom levels >= 3. This method is usable without any extensions to web mapping libraries, because the Equal Earth tiles are using the same tile grid as the Mercator tiles. The main usability problem is zooming into places far away from the center meridian. There should be a smooth transission between the two projections.

To improve on this, I've implemented a [MapLibre plugin](https://github.com/pka/maplibre-gl-equal-earth) which recalculates the map center coordinate when crossing zoom level 3. This improves zooming behaviour significantly and makes this combination of projections usable for end users.

<img src="../assets/equal-earth-zoom.gif" width="70%"/>

## Next steps

Resources about using an Equal Earth projection for web mapping are available on [equal.bbox.earth](https://equal.bbox.earth). As a next step I will add the plugin to the demos using MapLibre.

To use this new approach in production, extensions to all major web mapping libraries are needed. Ideally these are implemented by developers specialized on the respective library. Please [contact me](https://github.com/pka), If you're interested in collaboration or want to sponsor development!
