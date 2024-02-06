---
kind: article
author: "Daniel Kennett"
layout: post
title: "Swift on Windows"
created_at: 2024-02-09 14:00:00 +0100
categories:
- General
- Programming
---

There are many ways to write "cross-platform" apps - ranging from going all in on the cross-platform idea and writing a web app in something like Electron, to writing two completely separate apps that happen to look the same and do the same thing. And of course, the internet is *full* of… let's say "vibrant" discussion on what's the best way to do things.

My personal preference is to write the UI layer in a native technology stack in order to take advantage of a particular platform's look-and-feel, with the "core" logic in a cross-platform codebase that the native layer can interact with.

A drawback of this approach is that it does tend to limit your choice of programming languages for the cross-platform codebase. Programming languages all tend to have their own [ABIs](https://en.wikipedia.org/wiki/Application_binary_interface), and you need to rely on there being a "bridge" available between the two languages you want to use. In practice, this often means finding an intermediate ABI that both languages can interoperate with - and that is often the C ABI.

I've heard folks call C "the modern-day assembly", and you can see why. It's a *very* "close to the metal" language which provides little in creature comforts, and squeezing your object-oriented, garbage-collected language through it can be quite the challenge.

The next candidate is C++. It's a much more "friendly" language than C, but it's still rather bare. 

What about Swift? I love Swift, and write code in it every day. It'd be _great_ if I could ship CascableCore in Swift to multiple platforms, and Swift even has [official Windows builds](https://www.swift.org/download/).

However, the challenge comes not necessarily from compiling our Swift code on Windows, but from using it from *other* languages. Specifically in this case, I'd like to write a C# app using WinUI3 that uses our CascableCore camera SDK.

Well, maybe there's a solution. Swift recently introduced C++ interoperability… maybe we could use that to bridge between the two worlds? How hard could it be?

That little question, dear reader, led me down quite the rabbit hole. This blog post is an

If you already know what C++/CLI and a CLR is and don't need my life story, you can hop straight over to the [SwiftToCLR proof-of-concept repository](https://github.com/cascable/swift-on-windows-poc). The readme there is still pretty long, but it's a more technical document with the aim of getting folks more familiar with the technologies at hand to get stuck in. 

Otherwise, stick around! It's been a… journey. An exciting, fun, frustrating, tedious journey. But I learned a lot, and hopefully you'll enjoy coming along for the ride.

### What Are We Trying To Achieve?

My company has an SDK called [CascableCore](https://developer.cascable.se/), which talks to cameras from various manufacturers (such as Canon, Nikon, Sony, etc) via the network or USB. Its job is to deal with each camera's particular protocols and oddities as it presents a unified set of APIs to apps that use the SDK. This SDK is used by [our own apps](https://cascable.se/), as well as those from a number of third-party developers.

There's nothing particularly platform-specific about this task — networks and USB are cross-platform *by design* — so CascableCore is a great candidate to be a cross-platform codebase. It'd give us the option to expand our apps to more platforms in the future, as well as expand the potential customer base for the SDK itself. 

CascableCore's codebase currently looks like this — a bunch of Objective-C and some Swift. All new code is written in Swift, but still — there's a hefty amount of Objective-C in there:

[GitHub language spread graphic]

Despite its GNU roots, Objective-C isn't particularly multi-platform in the real world, so no matter *what* we do we'll be rewriting a significant amount of code to go multi-platform — and, *rationally* speaking, C++ is probably not a bad choice. We could do that RIGHT NOW.

However, dear reader, I'll let you in on a little secret if you promise not to tell anyone. Lean closer. Ready?

…I hate C++. Don't tell anyone, OK?

My dislike of C++ is, if I'm honest, mostly irrational. I've seen one horrendous [C++ template](https://en.cppreference.com/w/cpp/language/templates) too many. But, we could just… not do that in our own code, y'know? 

On the more rational side, though, we *are* a small company and our expertise *is* largely in Swift simply as a consequence of only having Mac and iOS apps at the moment. We've already dabbled in Swift on other platforms, too — [Photo Scout](https://photo-scout.app/)'s backend is written in Swift/[Vapor](https://vapor.codes) running on Linux servers, and it's been a great success. Since most of CascableCore's work is platform-agnostic, once the initial work is done we can (in theory) use our existing Swift expertise to maintain and improve CascableCore with only a relatively small additional cross-platform maintenance overhead

And… since we're being honest, it's just plain *fun* to explore new technologies, especially in more esoteric ways. Even if we don't end up shipping CascableCore in Swift on Windows, I learned a lot and (largely) had fun doing it. What's the downside?

Anyway, I'd being keeping half an eye on the Swift on Windows story over the past few months/years until a few months ago [this post on Mastodon](https://social.lol/@biscuit/111426362823414489) pulled on a thread in my brain:

<p><iframe src="https://social.lol/@biscuit/111426362823414489/embed" class="mastodon-embed" style="max-width: 100%; border: 0" width="600" allowfullscreen="allowfullscreen"></iframe><script src="https://social.lol/embed.js" async="async"></script></p>

This ended up being a perfect storm of circumstances: 

- Swift on Windows seems to be decently viable now.
- Swift had recently introduced the C++ interoperability feature, opening up possibilities for interacting with other languages. 
- I like to slow down a little and do interesting/"hack day" projects in December.
- I *really* wanted a reason to justify getting a [Framework laptop](https://frame.work/).

Not long later, my Framework laptop arrived and we were off to the races.

[Laptop photo]

### The Proof-of-Concept Project




