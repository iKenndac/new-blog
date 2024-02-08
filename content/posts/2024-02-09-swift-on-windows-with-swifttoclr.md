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

When putting together projects like this, it's always nice to be able to use "real" code. Luckily, we have the [CascableCore Simulated Camera](https://github.com/Cascable/cascablecore-simulated-camera) project, which is a CascableCore plugin that implements the API without needing a real camera to hand. This is a *perfect* candidate for this project — it's implementing a real, shipping API without the need for us to figure out network or USB communication on Windows. It's everything we need and nothing we don't. Also, happily, it's already all in Swift.

What *isn't* in Swift, unfortunately, is the CascableCore API itself. It was introduced before Swift, and has remained a set of Objective-C headers to this day. We'll need to redefine these in Swift.

Finally, we need a little bit of glue. CascableCore "proper" has a central "camera discovery" object that implements USB and network discovery, along with interfacing with plugins such as the simulated camera. We're not bringing that over to the Windows proof-of-concept, so we need something in its place so we can actually "discover" our simulated camera on Windows.

Getting all this into place took a few days — the simulated camera was *largely* fine other than needing to remove some Objective-C features (such as Key-Value Observing) and use of Apple-only APIs (such as CoreGraphics). Rebuilding the Objective-C API protocols into Swift ones took a couple of days, and the glue at the end a day or so.

Let's have a look at a little demo project on the Mac:

[Screenshot]

This little app discovers and connects to a camera, shows the camera's live view feed, shows some camera settings, and lets you change them. It's a simple enough app, but implements a decent chunk of the CascableCore API - issuing camera commands, observing camera settings, and receiving a stream of live view images. If we can get this working on Windows, we can get *everything* working on Windows.

Let's try to build this demo app on Windows!

### Figuring Out The Core Problem

The first step is to get the Swift code compiling on Windows, which was easy enough in our case (see above). The next is to instruct the Swift compiler to emit C++ headers for our targets:

~~~~~~~~ swift
swiftSettings: [
    .interoperabilityMode(.Cxx),
    .unsafeFlags(["-emit-clang-header-path", ".build/CascableCoreSimulatedCamera-Swift.h"])
]
~~~~~~~~

I will note that the Swift Package Manager doesn't officially support emitting C++ headers yet, hence the clunky unsafe build flag. This *has* been working fine for me, but the official way to do this is via another build system such as CMake.

At any rate, we now have a C++ header for calling into our Swift code! Now to Google "Calling C++ from C#" and… ah. 

Telling the story of two days of Googling would be *exquisitely* boring, so I'll skip ahead to why this is actually rather difficult after a quick foray into runtimes.

### A Rumble of Runtimes

A **runtime** can be thought of as a "support structure" for your code, providing functionality at runtime like memory management, thread management, error handling, and more. Swift, for instance, uses ARC (Automated Retain Counting) for memory management, and the runtime is the thing that actually does the allocation, reference counting, and deallocation of objects.

C# runs in the **CLR** (**C**ommon **L**anguage **R**untime), which is a garbage-collected runtime that's a lot more complex than the Swift one, providing additional things like just-in-time compiling.

The thing about a runtime - especially the more complex ones like the CLR - is that they need everything in the "bubble" they operate to conform to the same rules for everything to work correctly. The CLR's garbage-collection works because all of the objects in there are laid out in a particular way and behave the same way. A random Swift object floating around inside the CLR wouldn't be able to take part in garbage collection since the compiled code has no knowledge of such a thing — and the converse is true, too — a random C# object floating around inside the Swift runtime wouldn't be able to take part in ARC since it don't have the ability to call the Swift runtime's reference-counting methods.

There are two ways around this: exiting the bubble entirely and doing things manually, or "teaching" another language about your runtime.

Most runtimes *do* tend to have a way of "exiting" the bubble. C# calls this `unsafe` code, and Swift has a number of `withUnsafe…` methods. When in unsafe code, your memory management guarantees are gone (or exist in a very limited scope) and you, the programmer, are responsible for dealing with memory management yourself.

However, Swift's C++ interop feature is pretty neat in that it actually, in a way, "teaches" C++ about Swift's memory management. The Swift C++ interop header for the tiniest of tiny examples is what I describe as "5000 lines of chaos" - lots of imports and macros and templates that form a bridge from C++ into the Swift runtime, allowing you to use Swift objects directly in C++ while still taking part in ARC. Great!

The CLR *also* has a way of teaching C++ about the CLR's memory management in the form of a special "dialect" of C++ called [C++/CLI](https://en.wikipedia.org/wiki/C%2B%2B/CLI). Great!

Wait a minute…

### Why This Is Actually Rather Difficult

We're finally getting down to the *core* of the problem here. Let's lay out some facts, including a couple more that we discovered during that two days of excruciatingly boring Googling mentioned above:

- Swift's C++ headers contain a lot of additional infrastructure that "teaches" C++ about Swift's memory management.

- **NEW FACT!** Swift's C++ headers have a *lot* of `clang`-specific features in them, and as far as I can make out require `clang` to build.

- C++/CLI is a special dialect of C++ containing additional infrastructure that "teaches" C++ about the CLR's memory management.

- **NEW FACT!** C++/CLI can only be compiled by `MSVC`, the Microsoft Visual C++ compiler (or perhaps more accurately - `clang` *can't* compile it).

This is a little bit like those party games where everyone makes a statement about someone else and you have to combine everything to figure out who's lying. If you haven't managed that yet:

- `MSVC` can't compile the Swift C++ interop header.

- `clang` can't compile C++/CLI.

- This means that we can't create a C++/CLI wrapper from our Swift C++ interop header.

Crap.

Luckily, `clang`'s _compiled_ output is [(at least somewhat) ABI-compatible](https://clang.llvm.org/docs/MSVCCompatibility.html) with `MSVC`, so although `MSVC` can't compile the Swift C++ interop header, it _can_ link against the compiled output.

This, thankfully, opens a route through — we can make an **additional** wrapper layer, compiled with `clang`, that wraps the generated Swift/C++ APIs in, er… I guess… "vanilla" C++ that `MSVC` can deal with. The end-to-end chain would then be:

`C#` <-> `C++/CLI` <-> `Vanilla C++` <-> `Swift/C++` <-> `Swift`
| ------ MSVC ----- || --------------- clang ------------------| 

While this is a chain of four steps, we thankfully "only" need two wrappers:

- We have our Swift code that's compiled by `clang`, giving us a compiled binary and a C++ header.

- **Wrapper 1**: Compiled by `clang`, wraps the `clang`-generated Swift C++ interop header with a "vanilla" C++ one that `MSVC` can understand. The wrapper implementation calls the API defined in the C++ interop header.

- **Wrapper 2**: Compiled by `MSVC`, wraps the "vanilla" C++ header with a C++/CLI one that gets us into the CLR, and therefore up to C#. The wrapper implementation calls the API defined in **Wrapper 1**.

- We have our C# code, compiled by `MSVC`, running in the CLR. It calls the API defined in **Wrapper 2**.

This isn't actually that *difficult* - it's just very *tedious*. Each link in the chain has its own types, and they need to be translated in both directions (i.e., a C# `string` needs to end up as a Swift `String` when calling a method, then a Swift `String` being returned needs to end up as a C# `string` on the way back).

A simple, manually-made test project ends up looking like this:

[Screenshot]

It's not pretty, but it works!

### Making This Not Suck

Manually building two wrapper layers is, well, kind of a pain. For CascableCore it'd actually *largely* be a one-off cost - the API is fairly mature and stable, and we try not to change it unless we have to. Still, not fun.

Our case is fairly rare, though. Having to adjust two wrapper layers for every change you make as you work on Swift code is annoying enough to make you give up and not bother, so what can we do to make this better?

If you study the snippets of code in the screenshot above, a fairly strong pattern emerges even from such a small example.

For each "level", we need to:

- Make a class that holds a reference to an object from the level below,
- For each method on that wrapped class, have a corresponding method in the wrapper that:
    - Takes appropriate parameters for the method being wrapped,
    - Translates them all into types appropriate for the level below,
    - Calls the wrapped method with the translated parameters,
    - If needed, translates the returned value into a type appropriate for the current level and returns it.
- …and that's about it.

That's *extremely* repetitive and well-defined work, and it's a perfect candidate for…

…drumroll please…

**Code generation!**

### Introducing SwiftToCLR
