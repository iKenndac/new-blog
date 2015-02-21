---
kind: article
author: Daniel Kennett
created_at: '2011-01-08 16:15:34'
layout: post
slug: moving-to-the-app-store-how-not-to-do-it
status: publish
title: 'Moving to the App Store: How Not To Do It'
wordpress_id: '693'
categories:
- Programming-Work
---

<p>The Mac App Store was released a couple of days ago, and one of the main challenges for us developers with existing user bases has been what to do if we want our applications on the store — Apple don't give us a way to move our users to the App Store versions of our applications for free while allowing us to charge money to new users.</p>
<p>I've seen a few solutions to this from different developers, and the most prominent ones seem to be:</p>
<p><strong>Sell your application on the App Store store at normal price while continuing to distribute bugfix updates to existing users as before</strong></p>
<p>This is what I do, and it's the best of both worlds. Existing customers get updates and I get new customers through the App Store.</p>
<p><strong>Go App Store only for sales and refund existing customers if they'd like to buy your application again on the App Store</strong></p>
<p>This is how Realmac are dealing with the <a href="http://realmacsoftware.com/blog/mac-app-store-pricing">transition for their Courier application</a>.</p>
<p><strong>Go App Store only for sales, rewarding people who opt to purchase again with genuine added value</strong></p>
<p>An excellent example of this is how Pixelmator is <a href="http://www.pixelmator.com/">being transitioned</a> — they've temporarily discounted Pixelmator greatly and announced that it's going to be App Store only in the future. If users want to switch, they can't get a refund but they can buy it again for cheap, with the promise of a free upgrade to version 2.0 when it ships.</p>
<p>Since Pixelmator has been out for quite a long time, they're essentially letting users pre-order 2.0 on the App Store. However, right at the end:</p>
<blockquote>
<p>P.S. Even if you decide not to move to the Mac App Store we will continue to provide free Pixelmator 1.X updates til version 2.0.</p>
</blockquote>
<p>So, I get free updates to my current version <em>and</em> 2.0 for cheap? Sign me up!</p>
<p>Both of these solutions are great, as they treat customers and their money with respect. However, a fairly high-profile catastrophe happened with a little application called <a href="http://www.sophiestication.com/coversutra/">CoverSutra</a>. Their policy is:</p>
<p><strong>Go App Store only, give existing customers no refunds and if they want to receive any further updates, they have to buy the application again</strong></p>
<p>You can read the first explanation <a href="http://www.sophiestication.com/blog/coversutra-2-5/">here</a>, along with a followup to the backlash <a href="http://www.sophiestication.com/blog/about-coversutra-the-mac-app-store-and-sanity/">here</a>. People are <em>pissed</em>, and it strikes me that the application's author misunderstands <em>why</em> people are pissed.</p>
<p>In my Twitter stream I've seen a fair amount of discussion on this, and a lot of people defending the decision with things like:</p>
<ul>
<li>$5 isn't a lot of money! If they like the application enough, they should be happy to pay again.</li>
<li>I never expect free updates to any piece of software I buy.</li>
<li>That was a hard to keep promise, so it's OK that it's been broken.</li>
<li>It's only a little piece of software, why are people getting so pissed about $5? Surely they've got more important things to be worried about?</li>
</ul>
<p>All of those defences may be true. And don't call me Shirley. However, let me state a <em>fact</em> about software distribution, especially amongst indie developers. I will stake my reputation on this being true.</p>
<p><strong>The policy to give free updates to a purchased major version of a piece of software is so commonplace, if that's <em>not</em> what you do then you need to either state that explicitly at purchase time or, preferably, rethink that policy.</strong></p>
<p>I'm an application developer and I've <em>never</em> expected anything less from a software purchase. If I buy version 1.x of an application, I expect to get all the updates to 1.x for free, but then pay for 2.0. It's how everything I own works, and how I operate my own software. What if the 1.0 I buy only ever stays at 1.0 and I don't get any updates? Fine. What if the updates are only bug fixes? Fine!</p>
<p>So, having the update to CoverSutra 2.5 from version 2.2.2 be paid? Big no-no. However, this implicit expectation of free updates was explicitly backed up with this:</p>

<img src="/pictures/for_posts/2011/01/coversutra.png" border="0" alt="CoverSutra's Licensing Promise" width="590" height="315" />
{:.center .no-border}

<h3>Trust takes an age of good deeds to build, but only one misdeed to shatter instantly</h3>
<p>I bought CoverSutra, trusting that I'd get free updates as promised. My trust was broken, and even though it's over something as stupid as updates to a cheap little application, it makes me feel like an idiot for trusting in the first place. People don't like being made to feel like idiots!</p>
<p>No, $5 isn't much. Yes, things change, and you perhaps shouldn't promise things you're not sure you can deliver. Perhaps users shouldn't expect free updates unless you promise them.</p>
<p><strong>Tough.</strong> That's not how customers think.</p>
<p>If you promise free updates until version 3, give them. Even if you don't promise? Give them. If moving to the App Store and keeping a non-App Store distribution of your application going at the same time is too hard*, don't. Either be smarter about dealing with it, or wait until you have a major upgrade to distribute.</p>
<p>That's why people were pissed at Sophiestication to start with. Everything that followed — talking down at her customers, etc, just made things worse.</p>
<h3>Developers - Disagree At Your Peril</h3>
<p>Honestly? If you're an application developer and you disagree with me, then fine. However, I'd be willing to bet that you're also disagreeing with the vast majority of your customers, which is less fine. They give you money, and you probably need that money to live. Even if you don't? They give you money. When someone gives <em>me</em> money, I <em>damn sure</em> try to keep them happy, because I expect nothing less of people I give money to.</p>
<p>* I personally think the argument that keeping two distributions going is too hard is BS, and is just the developer being lazy. I do it, and it's not hard or time consuming at all.</p>