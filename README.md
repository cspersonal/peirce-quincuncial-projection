#Peirce Quincuncial Projection of the Sphere

The R-code provided can be used to project WGS84-coordinates into Peirce quincuncial projection. Until now there was no solution to do this in R.

Jason Davies has produced a [version](http://www.jasondavies.com/maps/peirce/) of a quincuncial projected map that almost looks like the one in Peirce' original [paper](http://www.jstor.org/stable/2369491) from 1879.

![quincunx](http://pbs.twimg.com/media/BD5Mu8_CEAEL7Vv.png)


##Properties

[The Peirce Quincunx](http://en.m.wikipedia.org/wiki/Peirce_quincuncial_projection) is one of the most beautiful map projections. It has the following properties:   
  * It is a conformal projection. Means it is no equal-area projection, it distorts the sizes of areas like the Mercator projection.
  * Its exaggeration of scale is only 9% whereas Mercator has 13%.
  * It has only 4 non-conformal points on the equator at the 90° angles. 
  * It represent the hemispheres as squares.
  * It tessellates the plane. This can be useful in thematic mapping to display different indicators simultaneously.

##The political Part: Affirmative Mapping
Like Mercator it (actually) shouldn't be used for thematic mapping, because it it distorts area sizes. But since google maps has defined Mercator as de facto standard also for thematic mapping, i think we are free to use the Quincunx. So why use it for thematic mapping?
  * One of the main points of Peters critique (see [Gall-Peters](http://en.m.wikipedia.org/wiki/Gall%E2%80%93Peters_projection)) of Mercator was that it exaggerates increasingly the size of land masses with growing distance from the equator. Therefore europe is relatively bigger compared to africa and so europe seems to be more important.
  * But Gall-Peters is in my opinion a aesthetic disaster.
  * So, when Mercator is the de facto standard, why shouldn't we do some counter projecting and exaggerate the size of areas with growing distance from the poles?
  * I see no reason not to use the quincunx, when mercator is used everywhere!   
  * Furthermore Gall-Peters doesn't achieve what it claims to achieve - a just representation of the world - because there is no relation between geographic size and the importance of a country in a economic, social or cultural area. If we want to achieve this (simultaneous representation of topological relations  and some statistical indicator), we should use [cartograms](http://www.worldmapper.org/index.html).

##The technical Part: Usage and Availability
Despite its beauty this projection is rarely known and used. Also it is not supported by the important projection libraries. Neither [mapproj](http://cran.r-project.org/web/packages/mapproj/index.html) nor [Proj.4](http://en.m.wikipedia.org/wiki/PROJ.4) support it. But there are exceptions. Micheal Bostock and Jason Davies have done with [d3-geo-projection](https://github.com/d3/d3-geo-projection) very, very valueable work. It supports the quincunx, but is only for webmapping and can't be used in R to plot maps as images.

Long story short: I found an tcl-implementation by Kevin B. Kenny [here](http://bibdigital.sid.inpe.br/col/iconet.com.br/banon/2009/09.04.15.17/doc/tcllib-1.12/modules/mapproj/mapproj.tcl) and translated it to R. The function //toPeirceQuincuncial// projects a geodetic coordinate quincuncial to the plane. I tested the function  once with the coordinates of the equator. The result was like expected a square.
 
