---
kind: article
author: Daniel Kennett
created_at: '2009-02-01 16:27:12'
layout: post
slug: kennettnet-software-what-makes-us-tick-and-how-we-got-there
status: publish
title: 'KennettNet Software: What Makes Us Tick And How We Got There'
wordpress_id: '203'
categories:
- Programming
---

Every programmer has a plethora of tools up their sleeve to make their job more about programming and less about managing the files and issues that come about. I thought I'd share the tools that make up our workflow.

90% of the time all our work is done in our office and at the moment, projects are rarely worked on by more than one person. The Windows version of Music Rescue 4.0 was a bit different, but the bits I worked on conveniently fit into frameworks that could be used by the main app. 

The other 10% of the time[^1] I'm working either at home on my iMac or on my travels on my MacBook.

[^1]: Although at the moment the ratio seems to be 90% at home and 10% at the office.

<strong>Design</strong>

<img src="/pictures/for_posts/2009/02/acorn.png" alt="acorn" title="acorn" width="140" height="140" class="alignright size-full wp-image-216" />
{:.center .no-border}

I often use <a href="http://www.omnigroup.com/applications/omnigraffle/" target="_blank">OmniGraffle</a> and <a href="http://www.omnigroup.com/applications/omninoutliner/" target="_blank">OmniOutliner</a> to make diagrams of processes and lists of... things, and I'm a big fan of Omni in general[^2]. However, normally nothing beats good old pencil and paper. I have several sketchbooks filled with sketches for various projects - these days, one or more per project. 

[^2]: Though it was better when Wil Shipley was there.

When I move to the computer, I use <a href="http://flyingmeat.com/acorn/" target="_blank">Acorn</a> for basic image editing and Photoshop for advanced stuff. Acorn really is a great little image editor - it's getting rarer and rarer that I use Photoshop for making interface graphics. 

<!--more-->

<strong>Coding</strong>

Our IDEs are fairly simple affairs. For writing Cocoa programs, we use the latest versions of Xcode and Interface Builder. For WebObjects apps, we use Eclipse and for .NET apps we use Visual Studio 2005 in Parallels. No custom editors or anything like that here.

<strong>Version Control</strong>

We're actually fairly new to "proper" version control. Music Rescue 3.x was written in REALbasic, which stores the entire project in a single file. Every version released I'd create a backup of the project file - more often when working on big upgrades. For our WebObjects and .NET projects I'd just backup the folders containing the projects. 

<img src="/pictures/for_posts/2009/02/bazaar.png" alt="bazaar" title="bazaar" width="140" height="143" class="alignright size-full wp-image-214" />
{:.center .no-border}

During the development of Music Rescue 4.0, we finally realised that we needed something better. After researching many of the systems, we came across <a href="http://bazaar-vcs.org/" target="blank">Bazaar</a>. It provides the ability to have local, folder-based repositories for simple projects, and distributed repositories for the larger projects that I need wherever I am. It's lovely and simple, and although there's no decent front end for it for the Mac, the command line version is simple enough for that to not really matter. There's an excellent overview of Bazaar <a href="http://www.mcubedsw.com/blog/index.php?/site/comments/version_control_with_bazaar/" target="_blank">here</a> on M Cubed Software's blog.

<strong>Issue Tracking</strong>

Our issue tracking for Music Rescue 3.x was a text file called "To-Do" in the folder for each version's project file. After that and a pen and paper both proved to be worthless, we experimented with publicly accessible web apps - first a normal forum where users could come and report their problems, then a specialised app called <a href="http://www.thebuggenie.com/" target="_blank">The Bug Genie</a>, still up at <a href="http://bugs.kennettnet.co.uk/" target="_blank">http://bugs.kennettnet.co.uk/</a>.

<img src="/pictures/for_posts/2009/02/lhkbanner.png" alt="lhkbanner" title="lhkbanner" width="100" height="149" class="alignright size-full wp-image-209" />
{:.center .no-border}

Neither of those went well - the forum was too general and The Bug Genie is too complex. After Music Rescue 4.0 was released, a fellow developer mentioned on Twitter that he was developing a front end to the online issue tracker called <a href="http://www.lighthouseapp.com/" target="_blank">Lighthouse</a>. I had a look and their tagline instantly hit home - "Beautifully simple issue tracking". After investigation, Lighthouse gave exactly what we needed - a service (albeit one that costs money) accessible from anywhere dedicated to issue tracking that's simple and easy to use. M Cubed's <a href="http://www.mcubedsw.com/software/lighthousekeeper" target="_blank">Lighthouse Keeper</a> is a wonderful front end that we can use to manage our projects' issues. 

<strong>Customer Support</strong>

For customer support, we use Mail that ships with Mac OS X. It isn't very good, and I'm starting to look for better alternatives.

<strong>Web Development</strong>

<img src="/pictures/for_posts/2009/02/coda.png" alt="coda" title="coda" width="140" height="140" class="alignright size-full wp-image-217" />
{:.center .no-border}

I used to use Dreamweaver, but it sucks. Fortunately, <a href="http://www.panic.com/" target="_blank">Panic</a> released <a href="http://www.panic.com/coda/" target="_blank">Coda</a>, and I no longer have to beat my head against the wall every time I need to update a bit of website. That said, Dreamweaver is handy for when I'm too lazy to write the HTML for a big table or can't remember how to make a drop-down menu, but other than that it gets launched rarely enough to get relaunched straight away by Adobe Updater. Sigh.

For the times I'm just uploading images or scripts or whatever, Panic again makes life easy with <a href="http://www.panic.com/transmit/" target="_blank">Transmit</a>. 

Basically, Panic == win. I miss Audion. If you want a genuinely interesting insight into Mac software development, read <a href="http://www.panic.com/extras/audionstory/" target="_blank">Audion's story</a> on their website. It's a brilliant read.

<strong>Other</strong>

<img src="/pictures/for_posts/2009/02/screenrecycler.png" alt="screenrecycler" title="screenrecycler" width="128" height="128" class="alignright size-full wp-image-221" />
{:.center .no-border}

At work, I use a Mac Pro with two 23" displays attached to it. When away I use a 13" MacBook. At home I have  24" iMac, but miss the dual screen setup. The solution? <a href="http://www.screenrecycler.com/" target="_blank">ScreenRecycler</a>, an application that "fools" your Mac into seeing a second screen that's actually the app hosting a VNC server. Connect to it from another machine and that machine becomes a secondary display! Over a wireless .11n network it's not quick enough to play video but it's certainly fast enough to do programming work on! Here's a photo of my home working environment using ScreenRecycler and my MacBook as a secondary display (click for a larger view):

<a href="/pictures/for_posts/2009/02/img_4470-1024x680.jpg"><img src="/pictures/for_posts/2009/02/img_4470-300x199.jpg" alt="Home setup with ScreenRecycler" title="Home setup with ScreenRecycler" width="300" height="199" class="aligncenter size-large wp-image-204" /></a>
{:.center .no-border}

When I started writing this post I could only remember a couple of apps that I used on a daily basis, until I started actually bringing up some of them as I worked. I didn't realise how many there were, and how many are from independent software developers like us. I'm glad I've contributed to the market I'm trying to make a living in!