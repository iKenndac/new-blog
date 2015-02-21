---
kind: article
author: Daniel Kennett
layout: post
title: "Secret Diary of a Side Project: Getting To 1.0"
created_at: 2015-02-13 19:30:00 +0100
comments: true
categories:
- Programming-Work
---

***Secret Diary of a Side Project** is a series of posts documenting my journey as I take an app from side project to a full-fledged for-pay product. You can find the introduction to this series of posts [here](/blog/2014/12/secret-diary-of-a-side-project-intro/).*

*In this post, I'm going to talk about something that strikes fear into the heart of any programmer: planning. You won't get to 1.0 without it!*

 ~  
{:.center}

If you're anything like me, it's likely that you have some form of issue tracker for your side project, detailing various bugs to be fixed and features to be added. In my instance, that ended up being a sort of rolling affair — I'd fix a bunch of things, see that my issue list was diminishing, then spend a while with the app prodding around until I found more things to add to the tracker. This was a perfectly acceptable approach in the beginning.

However, shortly after I committed to do this full-time, I realised I had no longer-term plan. So, I sat down and decided that I'd try to release 1.0 relatively soon after going full-time, allowing plenty of time to gain feedback from real photographers. You see, I have tons of feature ideas but until photographers tell me what they think, I don't really have any data to tell me if these ideas are any good. Releasing a 1.0 early allows the app to be shaped by its users, rather than my idea of what I think users want. 

This is the result, based on nothing more than a loosey-goosey feeling of the state of the project so far:

<table>
<thead><td>Milestone</td><td>Date</td></thead>
<tr><td>Start collecting beta invites</td><td>2015-03-10</td></tr>
<tr><td>First beta release</td><td>2015-03-24 → 28 </td></tr>
<tr><td>Post-beta questionnaire</td><td>2015-04-28</td></tr>
<tr><td>1.0 App Store submit</td><td>2015-05-05</td></tr>
</table>

Of course, I'll be amazed if those deadlines stick. Still! It's great to have something to aim for. I felt much better about myself. 

…for a while.

A few days later I looked at those dates and started to feel a bit of dread. That March 10th date is when I *really* commit to releasing something – it's when my marketing starts! I had *no* idea if I'd be able to do it or not. Eventually I realised the problem — the tasks in my issue tracker didn't connect my project from where it is now to that 1.0 on May 5th.

It's time to do some serious planning! 

### Shhh… Don't Say "Agile"

I have a love-hate relationship with Agile. My first exposure to it was when I started at Spotify in early 2011. The company was very small at the time, and we were using… scrum, I think? I forget. Anyway, as the company grew the thing we were using turned out not to work so well. So, we tried a new thing. Then another new thing. Then the first new thing again but with a slight modification. Eventually, I flat-out stopped caring. "Just tell me how you want me to stick the notes on the wall, and I'll be fine", I'd say. 

Fast-forward a few years, and a fellow named Jonathan joined the company. He'd written a book on Agile and handed out some copies. I took one with moderate-at-best enthusiasm, which then sat on my desk gathering dust. A few weeks later, he did a talk on a thing he called the "Inception Deck", a method of planning out your product at its inception stages. 

"This is perfect for Cascable!" I thought, and started furiously scribbling notes. After his talk, I told him I thought it was great. "Oh, really? I'm happy you think so — it's all from my book though."

At that point, I returned my copy of his book and bought an eBook of it instead, partly because I feel uncomfortable furthering my own app on something my employer paid for, but mainly because I like supporting good work. 

I feel really uncomfortable plugging things on this blog — it's not what it's for. However, Jonathan's book has *immensely* helped me as an independent developer trying to get an app out into the world, and a good deal of this post is inspired by things I learned from it. It's called *The Agile Samurai: How Agile Masters Deliver Great Software*, and you can find it [here at the Pragmatic Bookshelf](https://pragprog.com/book/jtrap/the-agile-samurai).

## Step One: Figure Out What You Want To Sell

If you were planning your app from the beginning, you'd start by planning what you want your 1.0 to actually be. A side project is completely the opposite of that — you just create a new project and go, plucking ideas out of your head and going with them.

However, that isn't sustainable if you want to ship a quality product, no matter how much you claim to "live in the code". At some point you're going to have to stop and figure this stuff out, which can be pretty daunting if you're just chugging along in your code editor. 

The "Inception Deck" I spoke about earlier really helped me with this. I won't go into it in detail — it's in the book I mentioned above as well as on [the author's blog](https://agilewarrior.wordpress.com/2010/11/06/the-agile-inception-deck/) – but it's basically a set of small tasks you can do to really help kick a project off in the right direction. 

Now, I'm not kicking off a project at all, and some of the items in the Inception Deck are geared a bit towards teams working on one project rather than the lone developer, but still — if some of the tasks help bring clarity to my project, I'm all for it!

Alright, it's time to jump out of development and pretend I'm doing this properly by doing the planning at the beginning. I cherry-picked the most relevant tasks from the Inception Deck, and here's what I came up with, more or less copy and pasted from my Evernote document:

### The Inception Deck for Cascable 1.0

### Why Are We Here?

This task helps establish why this project exists to start with.

> The applications that come with WiFi-enabled cameras tend to be pretty terrible. We can do better, and make a WiFi connection an indispensable tool on a camera rather than a toy.
	
 ~  
{:.center}

### Elevator Pitch

This is a fairly standard thing in the software world these days. Describe the product in 30 seconds.

> For photographers who need intelligent access to their camera and photos in the field, Cascable is an iOS app that connects to the camera over WiFi and opens up a world of possibilities. Unlike current apps, Cascable will develop and evolve to become an easy-to-use and indispensable tool for amateur and professional photographers alike.

 ~  
{:.center}

### The Not List

This is one is new to me and was incredibly helpful. Defining what **isn't** in scope for 1.0 can be as useful as defining what is.

**In Scope for 1.0** *— Things that will definitely make it.*

- Remote control of the basics: exposure control, focus and shutter. 
- Useful overlays for the above. Thirds grid, histogram, AE mode, AF info.
- Calculating exposure settings for ND filters and astrophotography.
- Saving calculation presets. 
- Viewing photos on the camera in the list.
- Downloading photos to the device.
- Viewing downloaded photos fullscreen, deleting downloaded photos.
- Sharing downloaded photos and opening them in another app.
- Apple Watch widget for triggering the shutter.

**Not In Scope for 1.0** *— Things that definitely won't make it.*

- Cameras that aren’t Canon EOS cameras. 
- Cloud functionality. 
- Automatic downloading.
- Support for videos in Files mode.

**Unresolved** *— Things I'm not sure about.*

- Second screen mode for AppleTV, etc.
- Applying Calculations Mode results to the camera.

 ~  
{:.center}

### What Keeps Me Up At Night

This exercise was also new to me. What things should you worry about, and which of those are beyond your control?

- Not having dedicated QA.
- Keeping “on the rails” and getting everything done properly and on time. 
- App Store rejection.
- Canon getting uppity.

The first two of those are things I know can fix myself already. The fear of App Store rejection is pretty much life as normal for iOS development, so there's no real need to worry about that as long as I'm familiar with Apple's guidelines and don't bump into the edges of the (admittedly sometimes vague) rules. That last one is more nuanced, and something I need to get legal advice about. *That* is where I should concentrate my energy into gaining knowledge.

### Conclusion

So, what's the benefit of writing all this down? Well, I've understood what this project is about the whole time, but succinctly describing it to someone else is a bit of a challenge. Not having answers to questions like "*Will you support X camera?*" or "*Can I work with video?*" was a bit embarrassing. Now, I can answer "*Not at 1.0, no.*" with confidence. Sure, I don't need to answer to anyone else while making my own app, but being able to answer questions to others with confidence does great things for your own internal confidence, too.

## Step Two: Fill The Gap Between Now And Then

Alright, so I've got an issue tracker full of tasks and a ship date. I also have a general overview of what Cascable 1.0 should be with the Inception Deck. However, I still haven't brought all this together to form a set of directions to take me from where I currently am on the project to where I want to be for 1.0.

The problem is, as the lone developer of an app, I'm just in too deep. I can't see the wood for the trees, and various other clichéd sayings about not having a clear view of the whole situation. I came up with all that stuff above completely on my own. How do I know if it's any good, or just pure garbage?
 
 What I need is an *outsider*.
 
<img src="/pictures/secret-diary/Alana.jpg" width="400" /> \\
 *Don't be fooled, she packs a mean punch.*
{:.center}

Meet Alana (that's "Ah-lay-na", not "Ah-lar-na"), who has agreed to be Cascable's Product Owner while I get to 1.0. She's also my wife, so I suppose she's also the Product Owner of, well, *me*. She's agreed to have meetings with me once every two weeks, splitting my journey into Agile-like sprints. I'll get to explain why I didn't meet any missed targets and why, which targets I did meet and what targets I plan to meet in the next two weeks. 

However, we're getting ahead of ourselves — my current problem is that even though I have a nice Inception Deck I don't know *exactly* what 1.0 should be, never mind how to get to it. Alana also had a concern: "How can I be your Product Owner if I don't know what the product is?" 

It turns out that my problem and her concern can be solved in one step. The reason my issue tracker doesn't connect between the current state of the project and 1.0 is because I just picked ideas out of my head when I ran out of tickets in my issue tracker. The Inception Deck helps, but it's still a bit wishy-washy — I need a well thought-out master list of stories to work against. A good way to have Alana know the product? Have *her* make the list!

### Business Time

One Saturday, we sat opposite one another at the dining room table with a pile of Post-It notes, some pens and a camera. 

"Alright, " I said, "You've just bought a camera and have realised how crappy the supplied app is. You're going to hire me to write you an app that enhances your photography experience. I want you to tell me what it should do, and we'll write each thing down on a note."

She picked up her camera, prodded at it a bit then said "Erm… I guess it should connect to camera, right?"

Great! Our first story — but this was the very first page, not where the storyline ends. We spent the next hour talking about photography and she made feature suggestions along the way, mainly based on her previous photography experiences. I didn't make a single contribution to the notes, other than to ask "*Why* do you want the app to do that?" to make sure that information got written down. Each idea got a note, and after an hour we had a fairly sizeable pile. 

After we were done, I quickly added some more notes that contained features I'd already written but she didn't independently come up with, then started the second half of the exercise: 

"Now, I want you to put these all in a line in order of importance to you."

Again, I didn't interrupt other than to help when she wasn't sure. "Should this go higher than *Delete photos from the camera* or lower?"

This is what we ended up with:

<img src="/pictures/secret-diary/Stories.jpg" />
{:.center}

For the first time, I sat back and actually studied the notes. I was *floored*. In front of me was a *complete* journey to 1.0 and beyond. Features I hadn't even thought of were high up the list, and of *course* they were — they were so stupidly obvious. Conversely, features I'd spent a fair amount of time working on (in particular, a "Night Mode" for the app) were right down towards the bottom, probably past the cutoff point for 1.0, and looking at the list I completely agreed with it being down there. In fact, I couldn't really argue with the order of the notes at all once I heard the reasoning behind Alana's chosen position.

I've been working on this thing for well over a year and a half now, and two hours with someone with fresh eyes completely changed the project and set it off on the journey to 1.0 with a flying start. 

What's better, every single outstanding bug or feature in my issue tracker fit into one of these Post-It stories perfectly. The app doesn't handle a camera in pairing mode quite right? Well, that goes in the "Connect to camera" story. Oh, crap — that's the most important story of them all, I should fix that right away!

## Step Three: [There's No Step Three!](https://www.youtube.com/watch?v=6uXJlX50Lj8)

This is an absolute lie. Step three is the hardest one of all. Now you have a spiffy plan, you have to *execute* it.

My project isn't a "side project" any more. Far from it — it has deadlines, a prioritised story list, and a product owner. Between the start of this post and now, it's transformed into a fully-fledged software project, and I'm letting it down by only working on it in my spare time. Four weeks from today, however, that's all going to change!

 ~  
{:.center}

Next time on *Secret Diary of a Side Project*, we'll swing back to some coding and talk about what happens when you ignore my advice and decide to refactor a piece of code that really doesn't need it.