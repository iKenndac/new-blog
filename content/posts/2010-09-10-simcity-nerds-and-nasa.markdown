---
kind: article
author: Daniel Kennett
created_at: '2010-09-10 15:48:14'
layout: post
slug: simcity-nerds-and-nasa
status: publish
title: SimCity, Nerds and NASA
wordpress_id: '600'
categories:
- Sweden
---

<p><img style="float: left; margin: 10px;" src="http://ikennd.ac/pictures/for_posts/2010/09/Twitter.png" border="0" alt="Twitter" width="230" height="382" />A few days ago, I wrote <a href="http://ikennd.ac/blog/2010/09/a-perfect-analogy-between-swedish-and-british-communication-and-travel/">this</a> post about the underground trains in London and Stockholm. This sparked the conversation you see to the left on Twitter.</p>
<p>SimCity!!! I <em>love</em> SimCity. I used to play it loads, but haven't had the chance to in a long time. I have the game installed on my Mac, but have lost the disc. After obtaining the disc again through <em>completely legitimate means</em>, I remembered why I stopped playing — SimCity 4 on the Mac is slooooooow.</p>
<p>Eventually, I bought the PC version for £10 and started playing. I saw that the game came with regions to play on that match real-life areas — London, San Francisco, New York, etc. Wouldn't it be fun to build a SimCity on a region that matches Stockholm? Yes, it would.</p>
<p>After searching for a while, it became apparent that I wasn't going to find one. Then, I stumbled upon a page <a href="http://www.sc4ever.com/knowledge/showarticle.cfm?id=1103">describing how to create SimCity 4 regions from a greyscale elevation model</a>.</p>
<p>Superb! All I'd need to do is find an elevation model of the Stockholm area and I'd be set! My search eventually led to the <a href="http://en.wikipedia.org/wiki/Advanced_Spaceborne_Thermal_Emission_and_Reflection_Radiometer">ASTER project</a> then to NASA's <a href="http://asterweb.jpl.nasa.gov/gdem.asp">ASTER GDEM</a> (Global Digital Elevation Model) site. After following an <em><a href="http://asterweb.jpl.nasa.gov/gdem-wist.asp">incredibly simple</a></em> order process and waiting a few hours, I had my data!</p>
<p>Problem is, the ASTER satellite data simply isn't accurate enough for my <em>incredibly demanding</em> needs, and the data I managed to get wasn't good enough. In the screenshot below, I've written "Stockholm" on the map approximately where Google Maps puts it at the same zoom level. The map shows the Stockholm city area and surrounding suburbs.</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://ikennd.ac/pictures/for_posts/2010/09/Map-NASA.jpg" border="0" alt="NASA ASTER GDEM" width="500" height="500" /></p>
<p>So, now what? Eventually, I turned to Google Maps. The standard and terrain maps, while lovely and clean, are covered in roads and labels. The satellite picture shows the water-covered areas fairly cleanly (a few clouds notwithstanding), so while it wouldn't give me a height-accurate SimCity region, I'd at least get one with the lakes and stuff in the right place, which is good enough for a game of SimCity.</p>
<p>I suppose.</p>
<p>So,  this is what Google Maps' satellite image gave me for the region:</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://ikennd.ac/pictures/for_posts/2010/09/Map-Sattelite.jpg" border="0" alt="Satellite Map" width="500" height="500" /></p>
<p>Using Photoshop, I manually selected all the water with the Magic Wand tool, and saved that selection. Then, I created a layer of flat 25% grey (just below sea level in a SimCity elevation model), and another one of flat 40% grey (just above sea level). Using the earlier selection, I punched a hole in the 40% grey to show the 25% grey underneath. The result:</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://ikennd.ac/pictures/for_posts/2010/09/Map-Final.jpg" border="0" alt="Map-Final.jpg" width="500" height="500" /></p>
<p>With that made, I followed the instruction on the page linked earlier to create a SimCity region. After fifteen minutes of data crunching as I experimented with getting the right scale, SimCity finally gave me this. Hooray!</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://ikennd.ac/pictures/for_posts/2010/09/Map.jpg" border="0" alt="SimCity Map of Stockholm" width="500" height="266" /></p>
<p>If you compare it with Google's terrain map of the same area, you'll see that apart from some jaggy edges on the lakes (which can be smoothed out in-game), it matches pretty well with the geography of the area:</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://ikennd.ac/pictures/for_posts/2010/09/Map-with-Overlay.jpg" border="0" alt="SimCity Map with Google Overlay" width="500" height="337" /></p>
<p>All this only took about four hours. Now I can finally play my game!</p>