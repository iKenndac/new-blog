---
kind: article
author: Daniel Kennett
layout: post
title: "Your Runtime And You"
slug: your-runtime-and-you
created_at: 2013-02-04 18:15
comments: true
categories:
- Programming-Work
---

There've been a [few](http://ashfurrow.com/blog/the-necessity-of-c-in-objective-c) [posts](http://ashfurrow.com/blog/seven-deadly-sins-of-modern-objective-c)[^your-runtime-and-you-1] [floating](http://ashfurrow.com/blog/objcmsgsend-is-not-your-bottleneck) [around](http://xinsight.ca/blog/saving-objc-method-calls/) the internets recently discussing some rules about when to use Objective-C or not, mainly focusing on performance but touching on code readability and maintainability too. These posts are all written by intelligent people who make reasonable arguments, I get a rather uneasy feeling reading them.

For a little while I couldn't place it, but today it came to me — these posts, to me at least, seem to be looking at the problem (or lack thereof) too closely, citing small code snippets and "rules" on how to fix them with the correct choice of language.

[^your-runtime-and-you-1]: Specifically, point 6 of that post.

## Clarifying the Problem ##

Now, the discussion has become slightly muddled between two issues - one is that Objective-C's runtime is slower than some other runtimes (like, say, C), and the other is of code efficiency. Since a method call has more overhead in Objective-C,  inefficient code is affected more than that same code in C, so people jump to the conclusion that Objective-C is slow and the followup fix is to move to C.

Inefficient code will always be slow. However, since a method invocation has more overhead in Objective-C than C, C++ or most other static runtimes, people who've just learned about the Objective-C runtime will often blame the runtime and switch to C.

Unfortunately, I need to be blunt here: If you think your code is slow because Objective-C is slow, you're wrong. Your code is slow because you wrote slow code.

## The Bigger Picture ##

In day-to-day programming, you may end up in a situation in which you're looking at `objc_msgSend` and thinking that Objective-C is too slow. If this is the case, there are only two outcomes.

1. You wrote inefficient code and need to go fix it. It sucks, but this will be 99.9% of cases.

2. You screwed up big-style and Objective-C genuinely isn't the correct tool for the job at hand. This sucks even more, because you misunderstood your problem and now have to scrap all of the Objective-C code you wrote and write it again in something else. This will be *very* rare.

Thinking about one implementation detail in your runtime (and with Objective-C, that invariably becomes `objc_msgSend`) is *not* thinking about the bigger picture and you'll go down a horrible road of writing little sections of code in C, copying data back and forth between the two runtimes and creating a big horrible mess. You'll start thinking things like *"Accessing this instance variable directly is way faster than using Objective-C properties. This'll make my app fast!"*, and will fall down that horrible trap of pre-optimising stuff that doesn't actually make a difference.

Instead, you need to be thinking about the *behaviour* of your runtime and how it affects your problem. Ideally, you should do this *before* starting to implement your solution to that problem.

### Problem 1: I looked at Instruments and objc_msgSend is 10% of my application's usage! ###

Is your application actually slow? If not, who cares? If you're making a lot of method calls, this is to be expected.

This problem has nothing to do with the Objective-C runtime.

### Problem 2: I profiled my application when it's acting slow, and it's some Objective-C code slowing it down! ###

Make your code more efficient. Depending on the nature of the problem, one or more of these might help:

* Stop doing obviously silly things. Loading huge images lazily on the main thread, for instance.

* Learn about [complexity](http://en.wikipedia.org/wiki/Computational_complexity_theory) and how to write more efficient code.

* Learn about perceptive performance. For example, if you do your work on a background thread and keep your UI fluid in the meantime, your application won't feel slow. It's better that your application remains fluid and takes ten seconds to do its work than it locking up for five seconds. Five seconds is indeed faster, but it *feels* a lot slower when an application's UI is blocked.

This problem also has nothing to do with the Objective-C runtime.

### Problem 3: I'll be working in a realtime thread and I'm worried about the fact that Objective-C is a dynamic runtime! ###

Aha! Now we're getting somewhere. 

Objective-C isn't slow. It simply isn't. However, one thing that it *is* is dynamic. Objective-C's dynamic runtime gives it all the wonderful features we adore, but it isn't appropriate for some uses.

Real-time threads *can be* one of those uses. 

But not because Objective-C is slow. 

Because it's *dynamic*.

A good example of a realtime thread is a Core Audio render thread. When I get that callback from Core Audio asking me for more audio data to play, I have *x* milliseconds to return that data before the audio pipelines run out of buffer and an under-run occurs, causing playback stuttering.

Because that number is measured in milliseconds rather than nanoseconds, Objective-C would be perfectly fast enough to perform it. In fact, if I wrote my audio code in Objective-C it'd likely work just fine. However, because I'm under contract to return data in a certain time, I can't safely use a dynamic runtime like Objective-C to implement it.

C, for instance, has a static runtime and a fixed overhead for method calls. Copy some stuff to the stack, jump to the function's memory offset, and away you go.

Objective-C, though, is dynamic and you can't guarantee a thing. Anyone can load a class into the runtime that overrides `-methodSignatureForSelector:` and redirects your method calls elsewhere, or can use something like `method_exchangeImplementations()` to swap out method implementations entirely. This means that at runtime, you can't count on anything being what you thought it was.

So, because I'm under contract to return within a certain time and I personally believe it's bad form to use a dynamic runtime in such a situation, I choose to implement that problem entirely in C.

## Conclusion ##

The decision to use the C language for problem 3 was entirely a high-level decision based on the behaviour of the Objective-C runtime compared with the problem at hand.

This is really how you should be thinking about your runtime. If you get to the point where you've got some slow code and are noticing an implementation detail of the runtime pop up, you need to go back and code better. If you've coded the best you possibly can, you need to learn to code better. If you've learned to code better and the runtime is still getting in the way, you chose the wrong runtime for the entire problem.

Notice that this entire post is devoid of *any* code samples. This is intentional — the point of this post is that you choose your language and runtime *first* based on your problem, not *second* because of a problem in your code. If you're switching languages and runtimes halfway through a problem, the issue is your approach to solving the problem, not the language or runtime you're using to solve it. 
