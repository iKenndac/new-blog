---
kind: article
author: Daniel Kennett
created_at: '2011-10-15 18:56:45'
layout: post
slug: arduino-dioder-part-three
status: publish
title: 'Nerd++: Controlling Dioder RGB LED Strips with Arduino, Pt. 3 - Hardware Tidyup'
wordpress_id: '771'
categories:
- Programming-Work
---

A month or so ago, I [wrote a post](http://ikennd.ac/blog/2011/09/arduino-dioder-part-one/)
detailing how I put together an Arduino Mega 2560, a couple of chips and
a pile of wires to allow me to control the colour of a set of IKEA
Dioder RGB LED strips in software, then a [follow-up post](http://ikennd.ac/blog/2011/09/arduino-dioder-part-two/) on
how to emulate Philips' Ambilight technology to create a pleasing
ambient light effect behind your computer's display.

Today, we'll be tidying up the hardware side of the project from the
current sprawling mess of wires:

[<img src="http://farm7.static.flickr.com/6090/6144802102_4c073bef12_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6144802102)
{:.center}

To a neat little box:

[<img src="http://farm7.static.flickr.com/6167/6245986547_e3f0d3dacc_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6245986547)
{:.center}

### Creating an Arduino Shield for DIODER LED Strips

An Arduino shield is a circuit board that connects to an Arduino and
contains a certain number of electrical components that perform a
certain task — you can buy pre-made shields to give your Arduino an
ethernet port, a display, and so on. We're going to make a shield that
stacks on top of the Arduino Mega 2560 and you can connect the LED
strips to.

On top of the things you already have, you'll need the following (Links
to Swedish store):

-   Soldering Equipment. If you haven't soldered electronics before, get
    a [strip board](http://www.kpsec.freeuk.com/stripbd.htm) and some
    spare components like resistors to practice with first.
-   Assorted lengths of wire.
    [Link](http://www.youtube.com/watch?v=mFxc1cAGlYU)] [[Real Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=432167&groupid=55653&sortafter=0&sortafterchild=0&refcode=f)
-   1x Box for Arduino.
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=680253&groupid=63894&sortafter=0&sortafterchild=0&refcode=f)
-   1x Proto-Shield for Arduino that includes stacking components.
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=820488&groupid=8841&sortafter=0&sortafterchild=0&refcode=f)
-   16x Right-Angled Strip Headers
    [Link](http://www.lawicel-shop.se/shop/custom/prod.aspx?productid=801883&groupid=8852&sortafter=0&sortafterchild=0&refcode=f)

Rather than step you through creating the board, I'll simply leave you
with the circuit diagram to implement and some photos of my finished
board.

<img src="http://ikennd.ac/pictures/for_posts/2011/09/ArduinoDioderWiring.png" />
{:.center .no-border}

[<img src="http://farm7.static.flickr.com/6179/6245984929_3832d9711b_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6245984929)
{:.center}

[<img src="http://farm7.static.flickr.com/6217/6245984219_7524ef81f3_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6245984219)
{:.center}

A few notes:

-   You'll notice that the circuit diagram is a bit different to the one
    originally presented in the first part of this series. This is to
    make creating a circuit board easier, and I've gone back and updated
    both the [original post](http://ikennd.ac/blog/2011/09/arduino-dioder-part-one/)
    and the [code on GitHub](https://github.com/iKenndac/Arduino-Dioder-Playground) for
    this new layout.
-   You can probably make your board look way neater than mine!
-   The connector pins for the LEDs are right-angled because there's not
    enough space in the box for vertical pins and the LED connectors.
    Angle the two sets of pins that aren't hanging off the board upwards
    slightly to make connection easier.
-   You can download a PDF of the diagram
    [here](http://ikennd.ac/pictures/ArduinoDioderWiring.pdf).

Once you're completed the board, it will stack on top of the Arduino
Mega just fine. Cop a bit out of the box to allow the Dioder cables
through, and you're set!

[<img src="http://farm7.static.flickr.com/6170/6245985891_1c71e68f58_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6245985891)
{:.center}

[<img src="http://farm7.static.flickr.com/6167/6245986547_e3f0d3dacc_z.jpg" />](http://www.flickr.com/photos/24169642@N06/6245986547)
{:.center}

### Moving Forward

As before, let me know [on Twitter](http://twitter.com/iKenndac) if
you'd like to share and thoughts or idea about this project. Now we have
a nice, neat box, in a couple of weeks I'll post the final part of this
series — a System Preference pane with accompanying service to let the
lights respond to various system events, falling back to the ambient
lighting when nothing else is happening. After that, I'll take a bit of
a break before starting the next, more ambitious, Arduino project.

Have fun!
