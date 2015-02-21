---
kind: article
author: Daniel Kennett
layout: post
title: "Secret Diary of a Side Project: Cold, Hard Cash"
created_at: 2015-02-04 22:10:00 +0100
comments: true
categories:
- Programming-Work
---

*Secret Diary of a Side Project is a series of posts documenting my journey as I take an app from side project to a full-fledged for-pay product. You can find the introduction to this series of posts [here](/blog/2014/12/secret-diary-of-a-side-project-intro/).*

---

Moolah. Cheddar. Bank. Cash. Benjamins. There are so many slang terms for money it's hard to keep track. It's not surprising, really — people typically dislike talking about money, and it's human nature to try and make light of something that's not even slightly fun. It's the same reason people make jokes at funerals, I suppose.

Money puts a roof over your head, food on the table and is a required thing to function in modern society (yes, Bitcoin still counts as money - there's always that one guy, isn't there?) successfully. *A fool and his money are easily parted*, the saying goes. Nobody wants to be a fool.

However, if you're serious about your project you're going to have to spend money on it at some point. If you don't, you're going to damage it in ways you might not be able to see until much later.

It's very difficult — perhaps even nonsensical — to spend nontrivial amounts of money on something that's solely a side project. However, now we're getting serious about this thing it's time for that to change — something that can still be really difficult to do even though we've [shifted our perception](/blog/2015/01/secret-diary-of-a-side-project-part-1/) of this project in other areas.  It really doesn't help that money tends to have a tendency to suck the fun out of things, either. It cuts fun stuff out of holidays, limits the size of your TV, and gets in the way of that Ferrari that should be on your drive. Spending money on software I'm perfectly capable of writing on my own? Where's the fun in that?

<img src="https://ppcdn.500px.org/26369209/3e4ad5be8c38815106a44ae5d0d05d8f149b6da2/2048.jpg" /> \\
 *This post is really text-heavy, so please enjoy this photo of the Northern Lights my wife took while you take a breather.* 
{:.center}

### Invest In Yourself

Time to be blunt: Without a bit of money put into it, your project will never be as good as it could be. If you refuse to put money into it at *all*, you should really stop now, or at least reverse course and keep your project as a side project. It's a harsh thing for me to say, but I really believe it.

*Trust yourself.*

If you're there "in theory" but are still struggling with it, try my patented FREE MONEY technique.

**NOTE:** I should probably point out that I'm not a financial advisor, and you really shouldn't listen to me. This will become apparent in the next paragraph, but still — I'm an idiot. Go talk to someone smart when deciding what to do with your own money. Like I said, money is serious business.

You know when you find a bit of money in your coat you completely forgot was there? Your immediate reaction is *"Sweet, free money!"*, despite the fact that it was your money to begin with and you're exactly back where you were before you lost it. You can just take that mental effect to an extreme — open a new savings account called "App Fund", choose a sensible amount of money to put aside and transfer it over. For bonus points, make an automated monthly/weekly transfer in there. Your money hasn't gone anywhere, it's still safe and sound.

Then, don't look at it for a while. Go do other things. A month or two later, when you've survived without that money completely without incident, come back to it. *Sweet, free money!*

Now you've followed my terrible advice (or hopefully not) and put some money aside for your project, how can it actually benefit your project?

#### Hire Someone Better Than You

Universal Rule #1: **Time is money** <sup>\[citation needed\]</sup>, particularly if time is constrained. If you can hire someone to do a way better job as you in a fraction of the time, you should seriously consider it.

Me? I'm terrible at designing stuff. I can throw together some lines that look sort of like an arrow, but that's it.

A few months ago, the core functionality of the app was settling down and it was time to start working on the UI properly, particularly the part of the app that dealt with photos.

My photo view was a simple grid. When you had a camera connected, it showed you the photos on the camera. When you didn't, it showed only the ones you'd downloaded. Seems simple enough! However, in practice, it was horrible.

<img src="/pictures/secret-diary/files-pre-designer.jpg" width="750" />
{:.center}

On the left, you see some photos you've downloaded. Then you switch on your camera and a couple of seconds later the view changes to the one on the right. Where'd my photos go? Well, I can see the speedboat towards the bottom there, but what about the one of the house?

I banged my head against this for a little while before throwing in the towel and taking to Twitter for help:

<blockquote class="twitter-tweet" lang="en"><p>Looking for a decent, available iOS designer I can hire for 2-3 hours to help me with some UX prototypes I&#39;m struggling with.&#10;&#10;Suggestions?</p>&mdash; Daniel Kennett (@iKenndac) <a href="https://twitter.com/iKenndac/status/509306786252615680">September 9, 2014</a></blockquote> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I got a few replies and picked two of the most interesting-looking designers to take a look at my UI. One of the two I was impressed enough with that I extended his assignment a bit, and plan to use a lot more as this project goes full-time.

Anyway, a stupidly short amount of time later, I had some great mockups that made *complete sense*, and I felt a bit stupid for not thinking of it before. Still! I'd spent not a crazy amount and come out with a professional designer's take on my problem, and the walls I was bumping against crumbled away and development picked up again.

It was money well-spent, in my opinion, *particularly* taking the "time is money" rule into account.

#### Buy Tools

Universal Rule #2: You can't build good things without good tools.

Having a little bit of money set aside lets you invest in those tools that make your life a lot easier but are difficult to justify on projects that don't have a dedicated budget.

In particular for me, the time saved by a single feature of [Sketch](http://www.bohemiancoding.com/sketch/) — the ability to automatically export to `@1x`, `@2x` and `@3x` with a single click is well worth the $99 it costs. Before I had a budget it was a struggle to justify when I get Photoshop as part of my $10/month Adobe Creative Cloud subscription. With a budget? No brainer.

#### Buy Hardware

Universal Rule #3: Always test with real hardware.

Alright, this one isn't really that universal. However, you really must work with real hardware when building software. Emulators are crappy.

Depending on your project, you might be able to get away with an iOS device or two and be done with it. It's *really* important, in my opinion, to get hold of the slowest device you support and test on that as much as you possibly can. If you run your app day-to-day on the slow thing, you'll kinda do performance optimisation as you go, which is much nicer than working with the latest and greatest for a year, then thinking "Oh, I should test on that old one" a week before release and finding it runs at 2fps!

For my project, though, I work with cameras. For a long time, I was just using the camera that started this whole thing, my [Canon EOS 6D](/blog/2013/03/canon-eos-6d-review/). It works perfectly well, but there's a few problems:

1. I can't really say I support "Canon SLRs" if I've only tested it with this one model of camera.

2. The constant testing and debugging cycles have really take a toll on the battery.

3. This is my *personal* camera, and as such I've spent a great deal of time setting it up to my liking. However, for testing purposes I have to screw around with it all the time, which gets annoying fast when I just want to go outside and take photos. Even worse, if my tests fill it up with photos of the wall and mess with the settings, I might end up missing a great photo opportunity.

To solve these problems, I bought a different model of camera that's dedicated to testing. This solves all of my problems — I can screw around with it all I like and not care, the mains adapter I bought with it means I don't need to worry about the battery, and the fact it's a different model means I can be more confident about compatibility.

However, you do have to kind of feel sorry for the poor thing. Some cameras get to take photos of beautiful models, some get to see the Northern Lights, others record a couple's most treasured memories on honeymoon. This one is destined to have a life chained to a desk by a power cord, taking photos of the wall.

Once Cascable ships, I should take it to somewhere beautiful to celebrate.

### My Expenses

Adding it all up, I've spent well over USD $1,500 on Cascable and I'm still only working on it part-time. Even with this in mind, it's been absolutely worth it in my eyes — the benefits the tools and services I've bought have boosted the quality of my project no end.

If you're interested, here's a list of my current and near-future expenses.

<table>
<thead><td>Item</td><td>Cost (USD) </td></thead>
<tr class="yellow"><td>Test Camera (Canon EOS 70D) </td><td>$999</td></tr>
<tr><td>Canon Mains Power Adapter</td><td>$119(!)</td></tr>
<tr class="yellow"><td>Design Services </td><td>$430</td></tr>
<tr><td>JIRA License</td><td>$25 </td></tr>
<tr class="yellow"><td>Sketch License</td><td>$99 </td></tr>
<tr><td>iOS Developer Membership</td><td>$99</td></tr>
</table>

As I approach launch, the costs will start to pile up:

<table>
<thead><td>Item</td><td>Cost (USD) </td></thead>
<tr class="yellow"><td>Various Hosting Costs</td><td>~$40/month</td></tr>
<tr><td>SSL certificate</td><td>$100-$500</td></tr>
<tr class="yellow"><td>Another Test Camera</td><td>~$600</td></tr>
<tr><td>Design Services</td><td>~$1,000 - $2,000</td></tr>
</table>

Not including workspace costs (which I'll discuss in a future post) *or* the cost of my own time (time is money!), I'm going to be several thousand dollars in the hole by the time I launch.

Once upon a time, a few mistakes ago, this number would have scared me away big time. But! If I'm not willing to invest in myself, how can I expect customers to invest their money and time into me and my app?

---

Next time on *Secret Diary of a Side Project*, we'll talk about taking your project and taking it from whatever state it's in right now through to launch, through careful planning and a little help from an outsider.
