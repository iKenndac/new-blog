---
kind: article
author: Daniel Kennett
created_at: '2011-09-13 20:48:22'
layout: post
slug: arduino-dioder-part-one
status: publish
title: 'Nerd++: Controlling Dioder RGB LED Strips with Arduino, Pt. 1 - Getting Started'
wordpress_id: '748'
categories:
- Programming
---

<img src="/pictures/for_posts/2011/09/ArduinoHeader.jpg" />
{:.center .no-border}

A few weeks ago, it came to my attention that IKEA do a set of
colour-changeable LED strips. I've been looking for a decent way of
providing some lighting behind my computer to reduce eye-strain for a
long time, and these seemed perfect:

[<img src="http://farm7.static.flickr.com/6066/6144250241_e2bd439ac8_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6144250241)
{:.center}

I was very pleased with them, but no self-respecting nerd would stop
here. *Especially* one who's seen Philips' Ambilight technology in
action!

Over a series of blog posts, I'll be explaining how I built a simple
controller for IKEA Dioder lights using an [Arduino Mega2560 unit](http://arduino.cc/en/Main/ArduinoBoardMega2560), then moving on to
explore various ways to utilise this control in software for fun and
awesomeness.

In this post, I'll be building an Arduino layout that controls the
Dioder LED strips, programming it to listen to messages on its serial
port and set the LED strips' colours accordingly, then making a simple
Cocoa application in Xcode that sends messages to the unit to match the
strips to colour wells in a window on-screen.

**Note:** If you see a paragraph starting with **Tangent:**, you can
skip it without losing information on how to build this project.

### I care not for your long and boring descriptions! Just give me the code and wiring diagrams!

You can grab the code over at the project's home[on GitHub](http://www.github.com/iKenndac/Arduino-Dioder-Playground), which
includes both Arduino sketches for uploading to the device and Xcode
projects for controlling it. The Arduino sketches require the [Arduino software](http://arduino.cc/en/Main/Software) and the Xcode projects
were written on Mac OS X 10.7.

You can download a PDF wiring diagram
[here](/pictures/ArduinoDioderWiring.pdf).

Enjoy!

[<img src="http://farm7.static.flickr.com/6090/6144802102_4c073bef12_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6144253033)
{:.center}

### Part 1: Creating the Arduino-based hardware layout

IKEA sell Dioder lights in a number of configurations — I went with the
set that includes four multicolour strips, a control box and a power
adapter (Store links:
[Sweden](http://www.ikea.com/se/sv/catalog/products/40192361)/[UK](http://www.ikea.com/gb/en/catalog/products/00202324)/[USA](http://www.ikea.com/us/en/catalog/products/50192365)).
The control box and power adapter won't be used once they're connected
to the Arduino, though.

The Dioder LED strips have 12VDC on a common anode, with three return
paths for the red, green and blue channels.

Ingredients (links to Swedish stores):

-   1 x Arduino Mega2560
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=690919&groupid=63894&sortafter=0&sortafterchild=0&refcode=f)
-   1 x 12v AC-DC Adapter
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=801708&groupid=0&sortafter=0&sortafterchild=0&refcode=p)
-   1 x A-B USB Cable
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=47306&groupid=8852&sortafter=0&sortafterchild=0&refcode=f)
-   ~40 x Male-Male Jump Cables (I got four packs of ten)
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=564449&groupid=64668&sortafter=0&sortafterchild=0&refcode=f)
-   2 x ULN2003 DIP-profile chips
    [Link](http://www.electrokit.se/ic-linjara-uln2003a-dip-16-7-darlington-drivare_40350032)
-   1x Breadboard with at least 20 lanes
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=610020&groupid=64668&sortafter=0&sortafterchild=0&refcode=f)

The layout here is fairly simple — power the Arduino with the 12V power
adapter, then tap into that for the anode on each LED strip.
[PWM](http://en.wikipedia.org/wiki/PWM) pins 2-13 (0 and 1 collide with
serial communication, which we'll be using on this project) on the
Arduino are connected to the ULN2003 chips, which act as relays for the
red, green and blue cathodes from the LED strips. Finally, the ground
pins on the ULN2003s are connected to the Arduino's ground to complete
the circuit.

Below are photos of the completed unit as well as a diagram of the
wiring. You may notice that the wiring in the photos isn't quite the
same as in the wiring diagrams — that's because I miswired the project
when I took photos of it. All code and future projects are based on the
wiring diagram.

[<img src="http://farm7.static.flickr.com/6176/6144253033_1e41e7feb9_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6144253033)
{:.center}

[<img src="http://farm7.static.flickr.com/6172/6144804622_28970d3dd4_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6144804622)
{:.center}

<img src="/pictures/for_posts/2011/09/ArduinoDioderWiring.png" />
{:.center .no-border}

You can download a PDF of the diagram
[here](/pictures/ArduinoDioderWiring.pdf).

### Part 2: Programming the Arduino

Rather than stepping through the process of listening to the serial port
and controlling the PWM pins, I'm going to jump straight to what I
implemented for the Arduino to listen to messages on its serial port and
set the PWM output values accordingly. However, if you haven't
programmed Arduino before, I strongly recommend visiting the [Arduino reference guides](http://arduino.cc/en/Reference/HomePage) and looking
at the sample projects included with the Arduino software to learn how
it all works — it's a lot of fun!

The protocol I implemented is very simple — two constant header bytes,
12 "body" bytes (one for each red, green and blue pin over four separate
LED strips) and a checksum byte (a bitwise XOR of all the body bytes).

<img src="/pictures/for_posts/2011/09/ArduinoDioderProtocol.png" />
{:.center .no-border}

*A message setting all connected LED strips to white/GBR(255,255,255)*

**Tangent:** Originally, I'd implemented the protocol without headers or
checksums — the Arduino would listen to the serial port and push each 12
bytes it got to the PWM pins. However, this was such a dumb idea — if
you accidentally sent the wrong length of data or some other app sent
data to it (which happened more than once), you'd never be able to get
it back in sync! You can find the Arduino sketch that listens for that
"protocol" in the sample code repository linked below at *Arduino
Projects/FourChannelRGBDumbListener/FourChannelRGBDumbListener.pde*.
Don't use it, though — it's dumb!

You can grab the finished Arduino sketch over at the project's [home on GitHub](http://www.github.com/iKenndac/Arduino-Dioder-Playground), at
*Arduino Projects/FourChannelRGBSmartListener/FourChannelRGBSmartListener.pde*.

### Part 3: Creating a Cocoa application to send messages to the Arduino

By now, you should have an Arduino successfully controlling your Dioder
LED strips. You can test this by connecting it all together (make sure
you connect the 12V adapter to the Arduino or the LED strips won't be
powered) and switching on the Arduino — the Arduino sketch I wrote will
switch all four strips to white until told otherwise over the serial
port.

My Dioder LED strips are attached to the back of my iMac as shown in the
photo at the start of this post, so I made this very simple application
— choose the Arduino's serial port from the menu, then change the colour
of the colour wells — the corresponding LED strip will change colour to
match!

<img src="/pictures/for_posts/2011/09/DioderColourWells.png" />
{:.center .no-border}

The full Xcode project can be found over at the project's [home on GitHub](http://www.github.com/iKenndac/Arduino-Dioder-Playground), at
*Xcode Projects/Dioder Colour Wells/Dioder Colour Wells.xcodeproj*. Just
to show how cool this looks in real life, I recorded a video to show it
off:

<p style="text-align: center;"><iframe width="853" height="480" src="http://www.youtube.com/embed/9xdL4xVEc24" frameborder="0" allowfullscreen></iframe></p>

### Moving Forward

Hopefully you've got a few cool ideas on what to do next — let me know
[on Twitter](http://twitter.com/iKenndac) if you'd like to share! In a
week or two I'll put up another post discussing some more advanced code
to make the LED strips respond to system events and so on. A little bit
further down the line, we'll start to get to the juicy stuff like live
image processing for having the LEDs react to what's on screen.

I hope this is enough to get you started, though. Have fun!


