---
kind: article
author: Daniel Kennett
layout: post
title: "Why Publishing Some Nice Autumnal Photos Online Made Me Write An App"
created_at: 2018-11-02 17:00:00 +0100
categories:
- General
- Programming
---

Don't care about programming and just want to see some pretty photos of colourful trees? Check out [Autumn From The Air](https://photos.ikennd.ac/autumn-from-the-air) on my new photos subsite. Enjoy!

---

A few months ago, I bought a drone with the idea of expanding the horizons of my photography hobby a little. I even had a dream photograph in mind - a rolling shot of my car driving along a mountain road. A few weeks later, I was standing on the side of a mountain road in the Alps, trying to take pictures of my car as my wife drove it up and down a section of mountain road. 

As it turns out, taking a long exposure of moving object A with moving camera B while standing in stationary position C is *incredibly* difficult. Over a couple of sessions I took hundreds of photographs, and got *four* that I'm happy with.

<img src="/pictures/drone-mx5-rolling.jpg" />  \\
*This photograph took many, many tries to get.* 
{:.center}

<img src="/pictures/drone-mx5-static.jpg" />  \\
*This photograph did not.* 
{:.center}

This was amazing! I have a *flying* camera! It's basically an infinitely adjustable tripod! I can even take rolling shots like this without hanging out of the back of a car!!

<img src="/pictures/drone.jpg" />  \\
*It's just a fancy tripod, really.* 
{:.center}

### Bureaucracy Strikes! 

Excited about the possibilities of this magic new camera, I came home and started learning and experimenting, having a lot of fun in the process. However, here in Sweden the laws surrounding aerial photography are very strict — you're not allowed to publish any aerial photographs without approval from Lantmäteriet, a Swedish agency dealing with land and property.

There's a valid discussion on how sensible this law is for private drone usage, since it's a law written in mind for imagery taken with planes and helicopters. Still, the law's the law, and I had a *great* set of autumn photos I wanted to share. Lantmäteriet has an online form for this, which requires each image's location, street address, and property allocation (which is looked up on Lantmäteriet's own map).

This submission process is, quite frankly, a massive pain in the ass. It took me 45 minutes to build the submission for 24 photos - manually pasting the coordinate into Maps, doing an address lookup, then going to the Lantmäteriet map to perform the other lookup there, scrolling and clicking around the map because you can't give it WGS84[^1] coordinates.

<img src="/pictures/lantmateriet-manual-table.png" width="600" />  \\
*Zzzzzzz…* 
{:.center}

### Like Everything, This Can Be Solved With Software!

I finished my submission, then immediately got to work automating this, because screw doing that again.

The most complicated part of the process is converting the WGS84 coordinates in my images' geotags into the SWEREF coordinate system that Lantmäteriet uses. It turns out that doing this well is hard, and I found some existing code to port over - it's several hundred lines!

After a few evenings of hacking, my 45 minutes of manually looking up things on two different maps can be reduced to typing this into my terminal: 

`$ lantmateriet-lookup -i *.jpg -html results.html`

…then waiting 30 seconds while it does its magic. Lovely! Under the hood, it's:

- Extracting a geotag from each image using `ImageIO`.
- Using `CoreLocation` to do a reverse geocode to get an address.
- Converting the WGS84 geotag coordinate into SWEREF.
- Doing a lookup on what is *definitely* a public Lantmäteriet API to get the property allocation.
- Writing the results of all that into a table for submission to Lantmäteriet. 

This is going to save a bunch of time for anyone that takes photos with a drone in Sweden, so I've made it open-source - you can find it here: [lantmateriet-lookup on GitHub](https://github.com/ikenndac/lantmateriet-lookup).

### …I Was Promised Autumn Photos? 

While I was faffing about with all of this, Lantmäteriet approved my original submission. Hooray! 

<img src="/pictures/drone-autumn.jpg" />  \\
*The slow currents of Mälaren disturb mud around an underwater rock.* 
{:.center}

I put together a photo story of my favourite aerial photos of the area around where I live, which you can find over on my new photos subsite: [Autumn From The Air](https://photos.ikennd.ac/autumn-from-the-air). Enjoy!


[^1]: WGS84 is the coordinate system used by GPS and many other mapping and navigation systems. If you see a GPS or map coordinate as you're going about your business, it's very likely that it's a WGS84 coordinate. 