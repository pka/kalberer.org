+++
title = "Sabbatical - the plan"
taxonomies.tags = ["sabbatical"]
+++

After working more than 20 years in my company, I decided to take a break from daily work and concentrate on personal projects and have more time for my hobbies.
My sabbatical started at February 1st and this is the rough plan for the coming year.

<!-- more -->

### BBOX

[BBOX](https://sourcepole.github.io/bbox/) is an ambitious project, building composable spatial services in pure Rust. It already covers most functionality of my Rust tile server [t-rex](https://t-rex.tileserver.ch/) and implements many OGC API standards, but requires a lot more time to make it an easy to use all-in-one package.

I plan to spend also time on other spatial Rust projects, especially [georaster](https://github.com/pka/georaster) and [copc-rs](https://github.com/pka/copc-rs) and generally want to hang around more in the amazing [GeoRust community](https://github.com/georust/).

### Goodbye Web-Mercator

Mainly because of programmers laziness (which can be a good thing!), 99% of today's web maps are in Web Mercator projection. My goal for this year is to help people using appropriate projections for making better maps. In 2018 Bojan Šavrič, Tom Patterson and Bernhard Jenny published their work on the [Equal Earth map projection](https://www.equal-earth.com/), an equal-area projection for world maps.

![](../assets/equal-earth.jpg)


This is the obvious candidate for replacing Web Mercator in web maps. I will evaluate using Equal Earth in tiled maps and the most important Javascript libraries. As a way to prove and document its usage, my plan is to publish maps covering topics like transport, weather, aviation and sensors. These will certainly benefit from an adequate world projection and are also use cases for real-time updates, another topic I want to investigate.

### Swiss-style relief shading with Machine Learning

In October 2020, a [paper](https://arxiv.org/abs/2010.01256) on relief shading using neural networks caught my interest. It shows the use of machine learning (ML) models to create accurate Swiss-style shaded reliefs.

![](../assets/relief.jpg)

I've contacted the Institute of Cartography and Geoinformation at ETH Zürich and they kindly gave me trained models from the paper for using in an Open Source implementation. So stay tuned for a QGIS plugin and maybe also an implementation for web browsers. 

### Godot Game engine

[Godot](https://godotengine.org/) is a Open Source game engine with an audience ranging from beginners to professional game developers. I'm convinced that game engines are the best tool for interactive 3D visualizations, but they are still rarely used in the geospatial world. Last autumn I've supervised two bachelor students visualizing vector tiles with [OSM data in 3D](https://github.com/Frataj/3D-OSM-GODOT) using Godot and I plan to work on a plugin for easy use of vector and raster map tiles in Godot.

There are many more game engine topics like COPC support, AR/VR, but implementing a little game, more than 30 years after learning programming by writing games, would be a highlight of the coming year.

### Outdoor and railway tours

There are a lot of software ideas, but having more freedom to plan will give me more opportunities for outdoor activities when there's good weather. Besides skiing, biking and hiking, I'm looking forward to spring, which is my favorite paragliding season at the Pizol.

![](../assets/palfries.jpg)

And I won't miss the opportunity to spend all school holidays with the kids, which are already collecting ideas for new [railway tours](https://kalberer.org/). 

If you want to stay updated or give feedback, you can follow me on [Mastodon](https://mapstodon.space/@implgeo) or watch this space for more blog posts through the year.
