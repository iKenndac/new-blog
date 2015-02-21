---
kind: article
author: Daniel Kennett
layout: post
title: "Where The Hell Is My Self-Driving Car?"
created_at: 2011-10-19 18:42
comments: true
categories:
- Gadgets
---

We've been promised self-driving cars for years. Hell, even *flying* cars! Where are they? Nowhere, that's where! 

Well, I've decided to take this into my own hands. In my [previous post](/blog/2011/10/arduino-dioder-part-three/) I mentioned that I've got a "more ambitious" Arduino project in the works, and today it arrived:

<img src="/pictures/rc/dualhunter_box.jpg" />
{:.center}

It turns out that interfacing with an RC is dead-simple - both the servo and the speed controller use the servo electronic interface, which the Arduino has libraries for.

Over time, I want to be able to solve the following challenge:

> Here's a GPS coordinate: (x, y). Get there.

The constraints of the challenge will be along the lines of:

- The environment will be a fairly open area with large obstacles (fields with trees, etc).
- The car won't have to worry about staying on roads.
- The car should take a reactionary approach to navigation and *not* do a grid-search of the area.
- The car should be able to go at a reasonable speed (> 10km/h or so).
- The car should recognise potential dead-ends and stop in time. 
- The car should recognise when a fatal problem (like ending up upside-down) has occured and give up. 

Given those constraints, the car will need at least the following sensors: 

- GPS
- Gyroscope
- Long-ish range distance (sonar or otherwise)
- Long-ish range wireless for diagnostics and emergency-stops

Thankfully, all of those are available for the Arduino. A friend of mine immediately started talking about advanced algorithms and video analysis when I mentioned this idea, but I hope to keep it much simpler than that, and given the environment the car will be in I hope to be able to pull off *something* with this project.

This will be a long-term project, especially since winter is rapidly approaching and if it's anything like last year's we'll be knee-deep in snow in less than a month. Still, I'll build the car soon and at least get it moving a bit under Arduino control.