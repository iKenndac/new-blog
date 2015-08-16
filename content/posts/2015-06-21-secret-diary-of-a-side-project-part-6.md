---
kind: article
author: Daniel Kennett
layout: post
title: "Secret Diary of a Side Project: In Reality, I've Only Just Started"
created_at: 2015-06-21 16:00:00 +0200
comments: true
categories:
- Programming
---

***Secret Diary of a Side Project** is a series of posts documenting my journey as I take an app from side project to a full-fledged for-pay product. You can find the introduction to this series of posts [here](/blog/2014/12/secret-diary-of-a-side-project-intro/).*

---

On March 27th 2013, I started an Xcode project called *EOSTalk* to start playing around with communicating with my new camera (a [Canon EOS 6D](/blog/2013/03/canon-eos-6d-review/)) over its WiFi connection.

Over two years and 670 commits later, on June 5th 2015 (exactly a [month late](/blog/2015/02/secret-diary-of-a-side-project-part-4/)), I uploaded Cascable 1.0 to the App Store. Ten agonising days later, it went "In Review", and seventeen hours after that, "Pending Developer Release".

Late in the evening the next day, my wife, our dog, a few Twitter friends (thanks to Periscope) and I sat together by my desk and clicked the *Release This Version* button.

<iframe width="320" height="600" src="https://www.youtube.com/embed/ZQYM9kuNXAU" frameborder="0" allowfullscreen></iframe>
<p>&nbsp;</p>

I absolutely meant to blog more in the three months since my last *Secret Diary* post, and I'm sorry if you've been looking forward to those posts. An interesting thing happened — I thought I'd have *way* more time for stuff like blogging after leaving my job and doing this fulltime, but I've ended up with *way* less. A strict deadline and a long issues list in JIRA made this a fulltime 9am-6pm job. So much for slacking off and playing videogames! 

Fortunately, though, I still have a few things I want to write about and now I can slow down a bit, I should start writing here on a more frequent basis again.

### Statistics

Some stats for Cascable 1.0 for the curious:

<table class="alt">
<tr><td>Objective-C Implementation</td><td>124 files, 23,000 lines of code</td></tr>
<tr><td>C/Objective-C Header</td><td>133 files, 2,400 lines of declaration</td></tr>
<tr><td>Swift</td><td>None</td></tr>
<tr><td>Commits</td><td>670</td></tr>
</table>

Now, lines of code is a pretty terrible metric for comparing projects, but here's the stats for the Mac version of Music Rescue, the last app of my own creation that brought in the Benjamins: 

<table class="alt">
<tr><td>Objective-C Implementation</td><td>154 files, 24,000 lines of code</td></tr>
<tr><td>C/Objective-C Header</td><td>169 files, 4,100 lines of declaration</td></tr>
<tr><td>Swift</td><td>This was 2008 — I barely had Objective-C 2.0, let alone Swift!</td></tr>
</table>

As you can see, the projects are actually of a similar size. It's a completely meaningless comparison, but it's interesting to me nonetheless. Back in 2008 I considered Music Rescue a pretty massive project, something I don't think about Cascable. I guess my experience with the Spotify codebase put things in perspective.

You can check Cascable out [here](http://cascable.se). You should totally buy a copy!

### Celebrating

At [NSConference 7](/blog/2015/03/nsconference-7/) I gave a short talk which was basically *Secret Diary: On Stage*, in which I discussed working on this project.

<div class="iframe-16x9-container">
<iframe src="https://player.vimeo.com/video/124337772" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</div><p>&nbsp;</p>

In that talk, I spoke about a bottle of whiskey I have on my desk. It's a bottle of Johnnie Walker Blue Label, and at £175 it's by far the most expensive bottle of whiskey I've bought. When I bought it, I vowed it'd only be opened when a real human being that wasn't my friend (sorry Tim!) exchanged money for my app.

Releasing an app is reward in itself, but there's nothing *tangible* about it. Having that physical milestone there to urge me on really was helpful when I was on hour four of debugging a really dumb crash, for instance.

This weekend, that bottle was opened. It tasted like *glory*.
