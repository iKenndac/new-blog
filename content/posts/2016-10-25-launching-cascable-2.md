---
kind: article
author: Daniel Kennett
layout: post
title: "Launching Cascable 2.0"
created_at: 2016-10-25 16:30:00 +0200
comments: true
categories:
- Programming
---

*Cascable* is the app I've been working on since early 2013 — firstly as a side project, then as a full-time endeavour starting mid-2015. You can read more about this journey in my *Secret Diary of a Side Project* series of posts, the first one  of which [can be found here](http://ikennd.ac/blog/2014/12/secret-diary-of-a-side-project-intro/).

---

"It won't be as stressful as the 1.0 release", I lied to my myself as much as my wife when she asked me how I was feeling about launching Cascable 2.0 the next day. I'd woken up a couple of times during the night in the past couple of weeks gnashing my teeth, causing a big chip in one of my teeth. 

The truth is, the 2.0 launch ended up being much more stressful than 1.0, although I genuinely didn't see it coming. Cascable 1.0 was a product of a side project — it shipped a few months after I quit Spotify, and a lot of that post-Spotify time was working on ancillary details like the website, marketing, documentation, and so on.

## Getting to 2.0

Version 2.0  shipped on August 11th, 2016 and was the result of nine solid months of work, starting in October 2015 with this tweet: 

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Autumn is in full swing and it’s exciting times here at Cascable as the road to multi-manufacturer support begins! <a href="https://t.co/NFFAmyyghs">pic.twitter.com/NFFAmyyghs</a></p>&mdash; Cascable (@CascableApp) <a href="https://twitter.com/CascableApp/status/657541898995937281">23 October 2015</a></blockquote> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Nine months is a *very* long time to be working on a single update, and it can be really damaging to your self esteem, particularly when working alone. Roughly 300 tickets were solved between starting 2.0 and shipping it. That's 300 issues. 300 things wrong with my code. 300 times myself or someone else had opened up JIRA and created a ticket to describe something was missing or broken with my code.

Of course, this is part and parcel of being a developer. However, you typically have other developers working alongside you to share the burden and a reasonable release cadence that (hopefully) provides real-world evidence that your work is good enough for production.

In the weeks before the launch, I didn't *feel* stressed at all — we'd had a very long TestFlight period with over 100 testers over all the difference camera brands Cascable now supports and all of the major issues were ironed out. I'd enforced a feature-freeze at the beginning of June, and a ship-to-App Store date of July 29th. That's two months in feature freeze and two weeks between uploading to the App Store and releasing — plenty of time to iron out any issues before shipping, and plenty up time to iron out any App Store problems before releasing. 

*Plus*, this time I had help in the form of [Tim](http://ikennd.ac/blog/2016/04/secret-diary-of-a-side-project-part-7/), who'd been diligently working away at the website for weeks — this time, it was finished by the time I'd hit code freeze and better than ever - much more content and some lovely extras like a nicely made video. 

Everything should be wonderful, right? Lots of time to iron out bugs, help with shipping and over 100 people using the app for a few months should make this launch something to be excited about. 

However, those nine months of JIRA tickets had taken their toll. My self-confidence was incredibly low, and I was scared to death that we'd launch and some stupid mistake I'd made would cause the app to crash for everyone, ruining the app's (and my) credibility. Cascable would be a laughing stock, and I'd have to go find a real job again.

On top of this, with 2.0 Cascable would be transitioning from paid-up-front to free with In-App Purchases to unlock the good stuff. It's a move we needed to make — a $25 up-front payment is an impossible sell on mobile — but a huge risk of doing this (and well-known enough that it was the first thing every developer friend I have mentioned when I told them of this plan) is receiving a massive amount of support email from free users and unfair one-star reviews.

> "You realise that you'll *immediately* get people downloading it without looking then leaving you one-star reviews because it isn't Instagram right?", said one.

As the Cascable launch approached, my belief in my own abilities was at an all-time low, and I was expecting to be buried in an avalanche of one-star reviews and email.

## Launch Day

Launch day came, and the app was sitting in iTunes Connect, waiting for me to click the "Release" button. An attempt at having it happen automatically was stymied by a problem with iTunes Connect that resulted in hours on the phone with iTunes Connect support, which ended up making the problem worse. In the end, I had to yank the previous version from sale a few days before 2.0's launch. D'oh!

<img src="/pictures/releasing-cascable-2/iTCHistory.png" width="350" />  \\
*This is not the history of a smooth release process!* 
{:.center}

I clicked the "Release" button, and braced myself for a horrible week.

<blockquote class="twitter-tweet" data-lang="en-gb"><p lang="en" dir="ltr">Launching an app is crazy - what a week! On Wednesday I was having to forcefully take breaks to keep the stress levels under control. 😰</p>&mdash; Daniel Kennett (@iKenndac) <a href="https://twitter.com/iKenndac/status/764185288411414528">12 August 2016</a></blockquote> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

But, the avalanche never came. Instead, we got great coverage, a big pile of downloads and some [really positive reviews](http://www.photographyblog.com/reviews/cascable_review/). 

In hindsight, I consider it a very successful launch. Neither my wildest dreams nor my deepest fears came true — the switch to freemium didn't make me an overnight millionaire, but we didn't get buried by one-star reviews and support email either.

It's amazing what shipping code can do to your self-esteem. After a couple of quick point-releases to fix some crashes that did crop up — all of them reasonably rare, thankfully — Cascable's crash-free sessions metric is in the very high-90% range (on the day of writing, it's at 98.5%). Of course that can be improved, but between the subjective reviews and this objective data, I've  completely regained my confidence that I'm able to write and ship a decent product. Hooray!

<blockquote class="twitter-tweet" data-conversation="none" data-lang="en-gb"><p lang="en" dir="ltr">Two days later, I’m bowing out the week with a great review and coverage on one of the largest photography sites there is. Much better! 😀</p>&mdash; Daniel Kennett (@iKenndac) <a href="https://twitter.com/iKenndac/status/764185315942727680">12 August 2016</a></blockquote> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

It's worth noting again what an incredible difference having someone helping out on stuff that isn't code. I don't think Tim would be upset with me if I said that he's by no means a professional website builder, nor is he a professional video editor. Yet, thanks to him, Cascable's launch had that extra layer of quality to it that I've never been able to achieve on my own.

So, with all of that self-congratulation out of the way, let's look at some cold, hard data!

## How did the launch actually go?

The established launch pattern for iOS apps is to have a huge launch spike that tails off fairly sharply. This "long tail" is a tough thing to endure, and [can be fatal](https://medium.com/swlh/how-our-app-went-from-20-000-day-to-2-day-in-revenue-d6892a2801bf#.6b3r10ffq).

Our spike followed normal trends. Here's our downloads over the first few days of 2.0:

<img src="/pictures/releasing-cascable-2/Cascable20Downloads.png" width="725" />  \\
*Downloads during the launch.* 
{:.center}

However, if we compare that to the number of purchases over the same period, a couple of things stick out: 

<img src="/pictures/releasing-cascable-2/Cascable20Sales.png" width="725" />  \\
*Purchases during the launch.* 
{:.center}

First, the spike for purchases was a couple of days *after* the spike for downloads. Second, the purchases graph doesn't lose quite as much momentum as the downloads graph, which (along with our retention data) shows that a decent proportion of that download spike was from drive-by users — people who had seen the app as part of the initial media push, tried it once, and never used it again.

## Was switching to Freemium the right thing to do?

I believe that Cascable is a pro-level tool and should command a pro-level price — particularly for a niche app in the physical photography sector. Yes, $25 is a *huge* barrier to entry on mobile, and our 1.x sales show that. However, the problem we need to solve is showing users that the app is worth the price it commands.

At the most basic level, yes, it was. Cascable is earning more money than it was than when it was paid-up-front. However, there's a lot more to it than that!

For several months, my plan was to have the app work with basic features for free, and implement a single In-App Purchase for $25 to unlock the whole app. However, after some discussion, we ended up shipping *four* separate In-App Purchases, as follows: 


<table class="alt">
<tr><th>Product</th><th>Cost</th><th>Description</th></tr>
<tr><td>Cascable Pro: Photo Management</td><td>$10</td><td>Support for RAW images, bulk copying, filtering and searching, image editing.</td></tr>
<tr><td>Cascable Pro: Remote Control</td><td>$10</td><td>Powerful camera remote control and shot automation tools.</td></tr>
<tr><td>Cascable Pro: Photo Management</td><td>$10</td><td>Support for RAW images, bulk copying, filtering and searching, image editing.</td></tr>
<tr><td>Cascable Pro: Night Mode</td><td>$10</td><td>A dark theme for the app.</td></tr>
<tr><td>Cascable Pro: Full Bundle</td><td>$25</td><td>All of the above.</td></tr>
</table>

The biggest detractor to this is development complexity. Different parts of the app need different feature checks, and we need to communicate to the user what they need to purchase to get which feature in a non-confusing way. Indeed, the latter point was worrying me up until launch due to the fact we decided that creating a [support article with a big-ass table](https://cascable.se/help/pro-features/) to explain it all was necessary.  

In practice, though, I think the user experience isn't too bad. We've only had one support ticket from someone who'd accidentally bought the wrong thing so far, which makes us hopeful it isn't too bad. 

The upside to all this added complexity is that we get to reduce sticker-shock ("$25?! Screw that!") and up-sell to the user. We're trying to avoid the aggressive sales pitch if at all possible, and don't start asking for money until the user wants to do something that isn't free. 

Here's a typical flow. Feel free to [download Cascable](https://itunes.apple.com/us/app/cascable-wifi-camera-remote/id974193500?ls=1&mt=8&at=1010l4JU&ct=homepage) and follow along!

Here's a typical screenshot of Cascable running as a free user. Notice there's absolutely no indication they haven't paid for the app.

<img src="/pictures/releasing-cascable-2/1-PhotosStart.jpg" width="768" />
{:.center .tight-border}

Here, the user has encountered a feature that requires them to part with some money. At this point, we don't pop up a store or otherwise interrupt their flow:

<img src="/pictures/releasing-cascable-2/2-PhotosProPrompt.jpg" width="768" />
{:.center .tight-border}

If they tap on a "Pro" button or a "More Information…" button, they'll get the In-App Purchase store showing the cheapest available purchase that'll unlock the feature they're trying to work with, along with a little video previewing everything that purchase will unlock. The video is shipped as part of the app bundle, so there's no waiting for it to download.

<img src="/pictures/releasing-cascable-2/3-StoreIndividual.png" width="571" />
{:.center}

If the user attempts to purchase the presented In-App Purchase, they'll be presented with this dialog:

<img src="/pictures/releasing-cascable-2/4-StoreBundlePrompt.png" width="571" />
{:.center}

This is where we get a chance upsell the user to the more expensive (but better value for money) purchase. If the user taps "View Pro Bundle", the purchase will be cancelled and they'll be shown the video and description of the bundle. Otherwise, the purchase of the requested item will continue.

<img src="/pictures/releasing-cascable-2/5-StoreBundle.jpg" width="571" />
{:.center}

Finally, once the user has purchased the unlock for a feature, the original message is replaced with controls for the feature itself.

<img src="/pictures/releasing-cascable-2/6-PhotosProFeature.jpg" width="768" />
{:.center .tight-border}

## Does our store work?

The remaining data is taken from a five week period during that long tail after the big spike.

Over the five-week period this data is from, our average conversion ratio from viewing the store to making a purchase was 21%. This compares to a conversion ratio of 4% from all users of the app to making a purchase. 

I'm pretty happy with 21% — less so with the 4%. What this data shows us is that we need to get people more interested in the expanded feature set — enough to go into the store to take a more detailed look.

Overall, our paid:free ratio is about 20%, which I don't feel is too bad. 

## Does our upsell work? 

This graph shows the *Entry Point* to the In-App Purchase store within Cascable - that is, the product they first see when the store is shown to them. As you can see, it's *reasonably* evenly spread between the three individual $10 unlocks, with the $25 bundle coming in last. This is because the only way to see the bundle first is to navigate to the "Purchases" item in Settings and tap the button next to the bundle. The rest are encountered when using the app normally.

<img src="/pictures/releasing-cascable-2/StoreShown.png" width="680" />  \\
*In-App Store entry point by product over five weeks during our long tail.* 
{:.center}

This next graph shows the products purchased over the same period. As you can see, the Full Bundle *significantly* outperforms the other products, despite the fact that it's more expensive and isn't the product the user is shown first in most circumstances.

<img src="/pictures/releasing-cascable-2/ProductPurchased.png" width="680" />  \\
*In-App Store purchases by product over five weeks during our long tail.* 
{:.center}

I think it's a reasonable conclusion that the upsell is having a positive effect on sales. However, we don't have enough data to say whether or not this is definitely the best approach. For that, we'd need to compare our upsell to the following scenarios: 

1) What if we still had four separate In-App Purchases at the same prices, but without the upsell from the $10 ones?

2) What if there was only one $25 In-App Purchase as originally planned?

However, my *feeling* is that we've hit a nice middle-ground. With no upsell, I'm reasonably confident that we'd sell less $25 bundles, and with no $10 options I think the sticker-shock factor would be too high.

## What Next?

Cascable 2.0 shipped in August , followed by an immediate feature update alongside the iOS 10 launch in September. In its current state, I consider the "2.x" app reasonably feature complete — engineering-wise, my tasks are to keep up-to-date with new cameras from our supported manufacturers, keep on top of customer requests, and regroup for Cascable 3.0. 

The aim is to make Cascable AB a sustainable business. While it's not quite there yet, we're certainly on the right track and the income graph is creeping up towards the expenditure graph.

As tempting as it is to dive into Cascable 3.0 right now, I've been looking at nothing but that app for a year now, and I'm risking burnout. Instead, over the next few months we're taking a radical departure from my own historic approach (SOLVE PROBLEMS BY PROGRAMMING!! *codes harder*) and will be putting effort into marketing the iOS app we have. 

For me, it's time to take a step back, hand Cascable's reigns over to Tim for a while, and focus on the long-term future of the company in the form of other engineering projects. This way, I can come back to Cascable 3.0 fresh and excited about the new features.

With that in mind, this next couple of months will be focused on the goal of making this company sustainable in the long term in ways that aren't adding new features to the existing app — it's feature complete enough that adding individual features won't make that critical difference.

### First Approach: Get more people to use Cascable

First, we're experimenting with various advertising streams to get users into the app and using it. So far, we're only in the first phase of this and are trying out Facebook, Instagram, Twitter, Google AdWords and App Store Search ads. It's too early to draw any conclusions from this, but it seems that App Store Search ads are significantly outperforming the rest.

Additionally, we're reaching out to photography websites, magazines, camera manufacturers, etc to try and get coverage. It's difficult for a tiny and unknown company like ours to wriggle through the noise, but we're starting to get noticed.

### Second Approach: Get more people to convert to paid users

Second, we recently shipped an update to Cascable that adds an "Announcements Channel" to the app. This allows us to publish content online for presentation to users inside the app. We're trying to make this visible to the user without being annoying — no push notifications, no noises, no alerts. Hopefully the little unread indicator won't be too abrasive to our users.

<img src="/pictures/releasing-cascable-2/Announcements.png" width="1024" />
{:.center .tight-border}


Our intent is to publish high-quality content roughly once per week at most, mainly in the form of previewing and linking to articles on our website about how to get the most out of Cascable's features — for example, a detailed article on using Cascable's automation tools to make time-lapse videos, long exposures of the night sky, and so on.

The channel allows us to present different content depending on what purchases the user has made, so for paid users we can say "Here's how to make this awesome stuff with what you  already have!" and free users we can frame it more towards "Look at the cool stuff you could do if you had this!".

The intention is to increase conversion from free users while at the same time increasing the happiness of our paid users by helping them get the most of what they have. This will be a tricky line to walk well, though.

### Third Approach: Don't put all our eggs in the iOS basket

Relying on one platform for income gives me the heebie-jeebies, particularly when that platform is one as difficult to reliably make money on as iOS. 

In a [previous *Secret Diary of a Side Project* post](http://ikennd.ac/blog/2015/01/secret-diary-of-a-side-project-part-2/), I discussed how I've been taking the extra effort to make sure our core camera connection stack is architected in a manner that keeps it cleanly separated from the Cascable app and fully functional on Mac OS as well as iOS.

With Tim working on the first two approaches, I've started working on branching out to Mac OS. Thanks to a fully functional core library, I've been able to cash in on this past work and start *incredibly* quickly — I built a functional (and reasonably polished) prototype of a Mac app in less than two weeks, and we're aiming to ship it by early December.

<img src="/pictures/releasing-cascable-2/TransferPrototype.png" width="700" />
{:.center .no-border}

## Conclusion

As much as being an overnight success is the dream, it doesn't tend to happen like that in the real world. After a couple of years of hard work, it looks like a sustainable business is starting to get within reach — Cascable's progress looks remarkably similar to that of my (mostly) successful foray into indie development all the way back in 2005. In fact, Cascable is doing *better* than my old company was after the same time period, but back then I lived in my parents' house basically for free — Cascable has a much higher bar to reach in order to be considered "successful"!


