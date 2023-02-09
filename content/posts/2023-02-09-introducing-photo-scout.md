---
kind: article
author: "Daniel Kennett"
layout: post
title: "Introducing Photo Scout!"
created_at: 2023-02-09 16:00:00 +0100
categories:
- General
- Programming
---

<img class="no-border" style="border-radius: 36px; box-shadow: 10px 10px 20px #ccc;" width="200" src="/pictures/photo-scout-icon.png" />

I'm really excited to announce **Photo Scout** to the world! It's going into a prerelease TestFlight period starting from today, with a public release sometime in spring or early summer.

The tagline of Photo Scout is "You tell us where. We tell you when." It's an app for anyone that likes to take photos — give it a set of criteria, and it'll tell you (with push notifications, if you want) when you can take that photo. It goes beyond just weather and golden hours — you can place the sun in a particular place in the sky, match against phases of the moon, and more (with more coming). There's some really amazing creative potential! 

<img class="no-border" width="600" src="/pictures/photo-scout-tf1-screenshots.png" />
{:.center}

Actually, rather than trying to list out *what* it can do, why don't I tell you *why*:

<p align="center">
    <video style="border: 1px solid #999; border-radius: 20px;" width="400" height="400" controls>
        <source src="/pictures/photo-scout-testflight-intro.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>
</p>

You can find out more about the app and sign up to be notified when you can join the TestFlight over on the [Photo Scout website](https://photo-scout.app/). You can also follow along with development on the [app's Mastodon account](https://indieapps.space/@photoscout) or on [my personal Mastodon account](https://mastodon.social/@ikenndac). The TestFlight will stay fairly small for the first week or two to make sure the servers don't fall over, but if you ask nicely on Mastodon you may well get in early too!

### How Photo Scout Came To Be

The last time I released a _completely_ new app was [Cascable](https://cascable.se/ios/) back in 2015. The first commit into that project was nearly ten years ago! There've been other apps along the way — notably [Pro Webcam](https://cascable.se/pro-webcam/) — but they've all been built around that core technology stack of working with DSLR/mirrorless cameras. 

I have a note on my computer full of random feature ideas for Cascable that've been gathered over the years. Some of them are sensible, some of them are ridiculous, and some of them are good ideas but not for that app. One of them has been there for a *long* time, and has always stuck with me:

> It'd be cool if the app could notify me when I could take a picture of the milky way

I really liked the idea, but it wasn't the right fit for an app for remote controlling and transferring images from a camera — so in the note it stayed. 

In 2020-2021 or so, a few desires coalesced: 

- The desire to learn something new.

- The desire to expand Cascable's target market with an app that doesn't need an expensive external camera to use.

- The desire to start growing the size of Cascable (the company).

That idea met all of those desires, especially since I actively *wanted* such an app… then, what started as the odd "Hey, what do you think about an app that…" conversation with friends slowly gained momentum through UI mockups, market research, an engineering prototype, then finally a point of no return — it was time to invest serious time and money into giving this a go!

### What Next?

The plan is as follows: 

- A smaller TestFlight phase starting from today to make sure the app's servers don't fall over with more than a couple of users.

- Then, over the coming weeks, increase the TestFlight size and add features and polish for a public release sometime in spring or early summer. 

Everything about this project is built using knowledge brand new to me. It's almost entirely SwiftUI, which is new for me. I've approached the app in a completely new, design-first way, which is new for me. It has a backend written in Swift with [Vapor](https://vapor.codes), both of which are new for me. It has AR components with some custom 3D programming, which is… well, you get the picture.

I've learned a lot — at times it felt like being at university again! — and there's a lot about Photo Scout that I'm _really_ pleased with (it has a theme song?!). Over the coming weeks as the TestFlight progresses and opens up to more people, I'll be writing some articles on here about some of the things I thought turned out really well, and some things that were more challenging.

---

So! If Photo Scout looks interesting to you, do [take a look at the site](https://photo-scout.app/) and sign up if you want to take it for a spin, and get in touch on the [app's Mastodon account](https://indieapps.space/@photoscout) or on [my personal Mastodon account](https://mastodon.social/@ikenndac) if you're interested in this earlier "Oh God the servers are on fire" phase.
