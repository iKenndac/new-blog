---
kind: article
author: Daniel Kennett
layout: post
slug: hacking-agile-style
title: "Summer Experiment: Hacking, Agile Style"
created_at: 2013-09-11 22:45
comments: true
categories:
- Programming
---

I've been working at Spotify for two and half years now. Previously, I ran my own software company for a number of years. Previously to *that*, I was in full-time education from the age of… well, whatever age you start going to nursery school. 

One big thing I've learned since being at Spotify is actually how to make a **product**. My Computer Science degree taught me how to **write programs**, and from that I went straight into shipping my own software. Honestly, now I've worked at Spotify for a while I realise what a *miracle* it was that we even shipped anything back then, let alone earn enough money to support multiple employees.

## Taking a Break From Programming? Let's Write a Program! 

Like all good programmers I know, I enjoy working on the odd spare-time project now and then. What typically happens in my case is that I sit down, go "Oh, I know!" and start coding. What I normally end up with is a working application that is *clearly* written by an engineer — it works just fine, but looks like someone fired the AppKit Shotgun at the screen.

The most recent example of this is my new camera. After [writing a blog post](/blog/2013/03/canon-eos-6d-review/) complaining about how it was stupid for having Facebook and Twitter built-in, I set about sort of reverse-ish engineering the protocol it uses so I could remote control it and download images from the comfort of my chair. The protocol is PTP over IP — PTP is a documented standard, and the "over IP" part is pretty standard too, which is why I hesitate to say I reverse-engineered the protocol. However, the proprietary extensions added by Canon are largely undocumented, which is where I've added new knowledge to the area.

After a couple of weekends with [Wireshark](http://www.wireshark.org) and Xcode, I had an Objective-C framework with a reasonably complete implementation of the PTP/IP protocol — enough to get and set the various properties of the camera, stream the live view image, perform commands and interact with the filesystem.

<img src="/pictures/hacking-agile-style/eostalk-mac-demo.png" /> \\
 *A typical side-project: function, but no form.* 
{:.center .no-border}

After a few weeks of doing basically nothing on the project, I went to WWDC and saw Apple's iOS 7 announcement. After years of being a "Mac and Frameworks" guy, I finally started getting excited about iOS UI programming again, and this camera project seemed like a great way to get back into making iOS apps and learning all the cool new stuff in iOS 7.

However, wouldn't it be nice to actually make a *product* rather than an engineer's demo project?

## Something Something Buzzword Agile

At Spotify, we use [Agile](http://en.wikipedia.org/wiki/Agile_software_development). I'm not a die-hard fan of Agile or anything (perhaps it's just our implementation of it), but I do appreciate how it lets you be organised in how you get work done and how it gives you a picture of what's left to do.

So, during my July vacation I set aside two weeks with the intention of making a little iPad app to remote control my camera. Rather than immediately creating a new project and jumping into code like I normally do, I decided to employ some techniques — some Agile, some plain common sense — to manage my progress.

### Step 1: Mockups

First, I spent a couple of days in Photoshop making mockups of what I wanted to do. The logic behind this was to try and avoid the "blank canvas" feeling you get a few moments after creating a new project in Xcode. With a few mockups under my belt, I would hopefully be able to dive right in without wasting time implementing a UI that I'd have easily seen was unworkable if I'd simply have drawn a picture of it. Indeed, my first idea turned out to be unusable because I'd assumed the camera's image would fill the iPad's screen:

<img src="/pictures/hacking-agile-style/second-sketch.png" /> \\
 *Originally, the app's controls would flank the image vertically, hiding and showing with a tap.* 
{:.center}

However, when I actually imported an image from my camera it was obvious that layout wouldn't work. I then spent a little while figuring out how to best deal with an image with a different aspect ratio to the iPad's screen.

<img src="/pictures/hacking-agile-style/third-sketch.png" />
{:.center}

<img src="/pictures/hacking-agile-style/fourth-sketch.png" />
{:.center}

<img src="/pictures/hacking-agile-style/fifth-sketch.png" /> \\
 *A few mockups refining the main UI. The challenge here is that the aspect ratio of the image coming from the camera isn't the same as that of the iPad.* 
{:.center}

### Step 2: Insults

When working on *anything*, having an open feedback loop with your peers is essential. With a project that needs to be done in two weeks, that loop needs to be fast and efficient. Unfortunately, I learned rather quickly at Spotify that in a normal working environment this is completely impossible — apparently, "That idea is fucking stupid and you should be ashamed for thinking otherwise" is *not* appropriate feedback. Instead, we have to have multi-hour meetings to discuss the merits of everything without being assholes to one another. Coming from the North of England, this came as a huge shock to the system — being assholes to one another is pretty much the only means of communication up there.

For this project, I enlisted the help of Tim (pictured above, enjoying a game of cup-and-ball). Tim and I are great friends, and as such hurl abuse at one another with abandon — exactly the traits required for an efficient feedback loop. Indeed, throughout the project he'd belittle and insult my bad ideas with such ruthless efficiency that I never wasted more than an hour or so on a bad idea.

This is basically the "rubber ducking" theory, except that the duck is a potty-mouthed asshole who isn't afraid of hurting your feelings.

### Step 3: Planning and Monitoring Tasks

This is the typical Agile stuff — I created a note for each task I needed to do in order to have the application I wanted and placed them on a board with *Waiting*, *Doing* and *Done* columns on it. On each note was an estimate on how long I thought that task would take in days, with a margin of error on tasks I wasn't that sure about — mainly those that involved more protocol reverse-engineering with Wireshark, since I hadn't figured out the advanced focusing and auto exposure parts in the protocol yet.

[<a href="http://pcdn.500px.net/42924806/8f69558fc2421062cd3773028f0b68adea8c2c8c/4.jpg" />](http://500px.com/photo/42924806)
{:.center}

Once I'd finished my board, I had between fifteen and twenty-five days worth of work to do in ten days.  Obviously that wasn't going to happen, but it was encouraging that everything that looked like it wouldn't make the cut was an advanced feature rather than core functionality.

### Step 4: Programming!

*Finally*, after three days of mocking and planning, I pushed "New Project" in Xcode and started coding. This seemed like a lot of honest-to-goodness work for what is supposed to be a fun side-project!

## Two Weeks Later…

As a bit of a side note: It's been a *long* time since I wrote a "proper" application for iOS (my last complete iOS app ran on the original iPhone), and I did everything the new way: it's all Auto Layout with roughly half of the constraints done in Interface Builder and the rest in code, and there isn't a `drawRect:` in sight. I had a lot of fun learning about the new stuff in iOS 7!

But, the golden question is… was adding three days of overhead to plan out what is ostensibly a throwaway side project worth it? Without it, I'd have had thirteen days to code instead of ten, and as a programmer I enjoy coding a lot more than I do planning and drawing boxes in Photoshop.

The answer, much to my surprise, is an unreserved YES.

### Progress

I greatly enjoyed the sense of progress moving notes across the board gave, especially when a task took me less time to implement than I'd estimated. It also gave me goals to work towards — having a task I was really looking forward to implementing on the board made working on the boring notes to get there go much faster.

### The Board is the Truth

Those little sticky notes really stop you from cutting corners, and cutting corners is what differentiates a hacky side-project from a polished product. For example, one of the most challenging things I encountered in the project was decoding the proprietary autofocus information the camera gives over PTP/IP. There are two main modes, one of which involves the user moving a single box around the screen and having the camera autofocus in that, the other of which user choses from a set of fixed points that correspond to dedicated autofocus sensors in the camera.

The "single box" method was simpler to implement, and I implemented both the protocol work and the UI for it in a day. At this point I was tempted to move on to something else — I mean, you could control focusing now, right? — and without that sticky note on my board I would have done so. After a bit of convincing by Tim, I just couldn't bring myself to lie to my board and I spent two days implementing the other autofocus method. I'm *really* glad I did, because I had a ton of fun and ended up with a much more polished product. 

<img src="/pictures/hacking-agile-style/af-contrast.png" /> \\
 *Contrast-detect autofocus was fairly simple to implement, as it's the same on every camera — a single rectangle is defined, which can be moved around the image to define the autofocus area.* 
{:.center .no-border}

<img src="/pictures/hacking-agile-style/af-phase.png" /> \\
 *Phase-detect autofocus was much harder to implement, mainly due to the focusing point layout — it's different on every camera. My camera only has nine points, but high-end cameras can have many, many more. This means parsing the autofocus info from the camera properly, as it'll have different data in it depending on which camera is used.* 
{:.center .no-border}

## Statistics

By the end of the two weeks, my application was in a state in which I could use it to take a photo of the board!

[<img src="http://pcdn.500px.net/42924784/6be6fdb82a60a51a09e5643bc95b528354e781da/4.jpg" />](http://500px.com/photo/42924784) \\
 *Cheesy action-shot…* 
{:.center}

[<img src="http://pcdn.500px.net/42924748/08736d1fb24a5dd106c8b0cfc7075cc90baeb2e8/4.jpg" />](http://500px.com/photo/42924748) \\
 *…of me taking this photo of the board.* 
{:.center}

As you can see, I added 1.5 days worth of work during the week and none of the advanced features got implemented, so all I have is a relatively basic remote control. However, this remote control is much, *much* more polished than it would have been if I hadn't planned it all out in advance, and I'm much more pleased with what I ended up with vs. an unpolished project with half-working advanced features.

The tasks that got completed are as follows:

<table class="alt">
<thead><td>Task</td><td>Estimated </td><td> Actual </td><td> Date Completed</td></thead>
<tr><td>Live View Image </td><td>0.5</td><td> 0.5 </td><td> 23 July 2013</td></tr>
<tr><td>Connect/Disconnect UI</td><td>2 </td><td> 1.5 </td><td> 23 July 2013</td></tr>
<tr><td>Grid</td><td>0.5 </td><td> 0.5 </td><td> 23 July 2013</td></tr>
<tr><td>Histogram</td><td>1 </td><td> 1  </td><td> 24 July 2013</td></tr>
<tr><td>Half/Full Shutter UI</td><td>1 </td><td> 1  </td><td> 25 July 2013</td></tr>
<tr><td>Property Controls</td><td>2 </td><td> 1  </td><td> 29 July 2013</td></tr>
<tr><td>Metering</td><td>2 ± 1 </td><td> 1  </td><td> 30 July 2013</td></tr>
<tr><td>AE Mode Display</td><td>0.5 </td><td> 0.5 </td><td> 30 July 2013</td></tr>
<tr><td>Exp. Compensation</td><td>0.5 </td><td> 0.5 </td><td> 30 July 2013</td></tr>
<tr><td>Live View Focusing</td><td>2 ± 1 </td><td> 2 </td><td> 1 Aug 2013</td></tr>
</table>

I did twelve estimated days worth of work in nine actual days, and I either estimated tasks correctly or overestimated how long they'd take. The three tasks I did added up to one and a half days.

## Conclusion

I actually like Agile in this setting a *lot* more than I do at work. I get to reap the benefits of organising my work without the tedium of the bureaucracy that you encounter in multiple-person teams of people you're contractually obliged to be nice to. This really shows in my output — the app I've made is really going in the direction a real product might, and if I decide I'd like to put this on the App Store I can just pick it up and keep going without having to go back and fill in all the shortcuts I would've made in a typical side project.

Most importantly, though: I had a *lot* of fun doing this — in fact, more than I normally do when working on side projects in a concentrated manner like this. Having mockups to work from and a visualisation of your progress made this project an absolute blast for me.