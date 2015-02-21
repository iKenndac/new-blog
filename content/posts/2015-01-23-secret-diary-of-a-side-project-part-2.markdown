---
kind: article
author: Daniel Kennett
layout: post
title: "Secret Diary of a Side Project: Coding Practices"
created_at: 2015-01-25 18:50:00 +0100
comments: true
categories:
- Programming-Work
---

***Secret Diary of a Side Project** is a series of posts documenting my journey as I take an app from side project to a full-fledged for-pay product. You can find the introduction to this series of posts [here](/blog/2014/12/secret-diary-of-a-side-project-intro/).*

*In this post, I'm going to talk about some of the coding practices I've picked up over the years that really make a difference when working on projects that have a limited time budget.*

---

There are *tons* of coding practices that help us be better, faster, more understandable as coders. However, although this post is pretty long, I only talk about two practices — both of which are focused on keeping projects simple to understand for people new to the project. That's *really* important for a side project you intend on seeing through — because you're working under severe time constraints, you may well go months between looking at a particular part of a project. You'll be a newbie to your own code, and *future* you will love *past* you a lot more if *past* you writes a simple, easy-to-understand project.


### Keep Dependencies Down, Keep Dependencies Static

Might as well get the most unpopular one out of the way first — I dislike third party dependencies, so I keep them to an absolute minimum. CocoaPods is a third party dependency to manage my third party dependencies, so I don't use that at all.

My app has four third party dependencies, one of which isn't included in release builds (CocoaLumberJack).

- CocoaLumberjack
- Flurry
- MRProgress
- Reactive Cocoa

The list itself isn't important. What's important that each item in it only got there after careful consideration of the benefits and drawbacks.

There's a huge amount of discussion online about CocoaPods, and I'm going to ignore all of it — CocoaPods doesn't really add much for the way I approach projects, so I don't use it.

So, how does a dependency end up on that list?

1. If I end up in a position where a third party library might seem useful, I figure out if I should rewrite it myself. After all, I don't truly know how something works unless I wrote it, and if I want 100% confidence in my product, I should write it all (within reason).

2. If I actually decide I want to use the library, I'll find the latest stable release of it, add it to my project, and start using it.

3. I never touch or update that dependency again unless I have a good reason to.

Point 3 in particular makes most of CocoaPod's usefulness moot. A *requirement* for me to use a third party piece of code is that it's mature and stable. If they're updating the library frequently and I'm required to keep up with those updates to avoid problems, well, that library gets deleted and I find something else.

Using this approach, I can concentrate on making my app better rather than making sure the spiderweb of dependencies I've added don't screw things up every time they get updated.

### Model Code Goes In A Separate Framework Target

While preparing for this post I had a look back at my previous projects and it turns out I've been doing this since I started programming in Objective-C and Cocoa back in 2006, and I really love the approach.

<img src="/pictures/secret-diary/Casable-Targets.png" width="218" />
{:.right}

Basically, if it doesn't involve UI or application state, it goes in a separate framework. My iPod-scanning app Music Rescue contained a complete framework for reading an iPod's database. My pet record-keeping app Clarus contained one to work with the application's document format.

Even though my camera app isn't ready yet, I have a stable, tested,  fully-documented framework that cross-compiles for iOS and Mac OS X. That framework takes complete care of camera discovery, connections, messaging queues, and all that jazz.

It's true that this actually adds more work for you, at least at the beginning. Isn't this post supposed to be about making your life easier? Well, the long-term benefits far outweigh the extra work.


#### It Provides Separation Of Responsibilities

A huge benefit to this is code readability and separation of process. Suddenly, your application has a huge set of problems it just doesn't have to care about any more. Sure, *you* need to care about them, but your application doesn't. It makes the application lighter, easier to work with and that bit less complicated to understand.


#### It Encourages You To Future-Proof and Document APIs

This is an interesting one. Now your logic is in a completely separate target, suddenly it's a product all of its own. It needs documentation. It needs a stable and thought-out API.

<img src="/pictures/secret-diary/Mac-Demo-Connecting-Code.png" width="699" /> \\
 *This code in the Mac Demo app hasn't changed since 2013, even though camera discovery has been refactored at least twice in that time.* 
{:.center}

This pays dividends down the road if pulled off correctly. Designing APIs is hard — I've been designing public APIs for Spotify for a number of years now, so I've stumbled through all the terrible mistakes already. Some pointers for designing APIs that stand the test of time:

- No non-standard patterns get exposed publicly. Sure, your task abstraction layer/KVO wrapper/functional programming constructs are amazing now, but in two years? You'll regret exposing it publicly when you move to the new hotness. Plus, users shouldn't need to learn your weird thing just to connect to a camera — even if that user is you in six months.

- Document *everything* as you go. Header documentation is great in Xcode these days.

<img src="/pictures/secret-diary/Mac-Demo-HeaderDoc.png" width="538" /> \\
 *"How does this thing behave again?" **Opt-Click** "Aha!"* 
{:.center}

- If you need to do background work, have the library completely deal with it. The client application shouldn't have to care about it at *all*. A common pattern is to have public methods dispatch to a queue/thread privately managed by the library, with the aim of making the library somewhat thread-safe. If clients find themselves needing direct access to the private queue/thread, rethink your APIs so they don't — it's a pretty bad code smell. Always document what queue/thread callbacks come back on, or take a parameter to let the client tell you.


#### It Makes Quick Prototyping and Testing Crazy Easy

This is my favourite benefit of the multi-target approach, and where you really start to reel in the time savings. Making the core of the application compile for Mac OS X means I can prototype *super* easily.

I have a Mac target called *Cascable Mac Demo*. It's a wonderful little debugging tool — it supports viewing all of the camera's properties, taking a photo, browsing the file system and downloading files, and streaming the camera's viewfinder image. Thanks to having a feature-complete library with a thought-out API, the *entire* application is less than 250 lines of code.

<img src="/pictures/secret-diary/Cascable-Mac-Demo.png" width="728" />
{:.center .no-border}

This little application makes building and testing new functionality a breeze. When launched, it'll connect to the first camera it finds and sets up just enough state to allow me to add some code to test some new stuff as it's being built.

This is a much better approach than adding some random code somewhere in the main iOS app to make sure new functionality is coming together properly, and makes sure my core functionality is mostly working and complete before it ever goes into the main app.


#### It Gives You Flexibility

What if I want to release a Mac version of my app one day? Well, the core functionality is already compiling, running and tested on Mac OS X. Hell, the Mac Demo app is more full-featured than some proof-of-concept apps I've seen!

If you want to be *really* flexible and are seriously considering multiple platforms, write your core framework in something cross-platform, like C# (or C++ if you hate yourself). The benefits of a constant, mature, tested library across all of your platforms will pay dividends.

<img src="/pictures/secret-diary/Cascable-Sharp.png" width="730" /> \\
 *Cascable in C#? Why not?* 
{:.center}

---

Next time on *Secret Diary of a Side Project*, we'll talk about one of the most difficult things in this whole process: cold, hard, cash money.
