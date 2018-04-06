---
kind: article
author: Daniel Kennett
layout: post
title: "App Store Subscriptions And You"
created_at: 2018-04-06 18:00:00 +0100
categories:
- General
---

For the average iOS developer, implementing App Store subscriptions is easily the most legalese-filled part of the entire process of making an app and shipping it to the world.

What makes this more difficult is that right now, App Store subscriptions for "normal" apps (i.e., those that aren't content services like magazines or Netflix) are *reasonably* new, and Apple appears to be finessing the rules over time. This can cause a frustrating situation as you try to do your best but end up getting repeated rejections due to your app not meeting the rules.

At the time of writing, I've been shipping an app that uses subscriptions for eight months, and have had multiple subscription-related rejections happen between my first release and now due to changing rules and changing enforcement of existing rules. The information in this post is a combination of my experience, as well as conversations with App Review both via email and phone. Hopefully the additional context provided by speaking to a human being from App Review on the phone will be as helpful to you as it was for me.

**Important:** This post was as correct as I could make it at the time of writing (early April 2018). The App Store review guidelines are a constantly changing thing, *particularly* in the area of subscriptions. You **must** do your own due diligence.

### The Paid Applications Contract

A lot of the confusion from this stems from the fact that half of the rules for subscriptions aren't in the [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/), but are instead located inside your **Paid Applications Contract**. You can find this in the **Agreements, Tax, and Banking** section of iTunes Connect. 

Assuming that you have the standard contract, in-app subscription terms can be found in section **3.8**.

**Important:** Your ability to sell apps on the App Store depends on your adherence to and understanding of this contract. Since this is a legal document, I will **not** be able to help you with it. This post is intended to be a guideline only, and I can't be held responsible if you encounter problems following it. If you have questions or problems with this contract, consult a lawyer. 

### What We're Building

This is a screenshot of my app's store. It provides users the option of buying a one-off In-App Purchase or one of two subscription options. This store page was approved by App Review in early April 2018.

<img class="no-border" src="/pictures/app-subscriptions/iphonex-legalese.png" width="300" />
{:.center}

As well as getting the in-app UI correct, you must also include details of your subscriptions in your app's App Store description. We cover this towards the end of the post. 

### You Must Be Clear About Pricing And Billing Frequency 

You *must* be very clear about several things:

- That the user will be paying for a recurring subscription. 
- How much the user will pay each time.
- How often they will pay.
- The pricing must be in the user's App Store currency. 

You'll see in my screenshots that my device is set to English, but I'm being presented prices in Swedish krona (SEK). This because I live in Sweden (so my cards are all in SEK) but I'm bad at Swedish, so my iPhone is set to English. You can't use the system locale for In-App Purchase pricing - instead, the `SKProduct` objects you get in the App Store will contain the locale you should use for displaying prices. 

A common thing to do is to offer multiple subscription options, giving the user better value for money if they commit to a longer subscription period. This is fine, but you *must* list the actual amount that will be charged in your pricing.

<img src="/pictures/app-subscriptions/subscribe-buttons-bad-frequency.png" width="300" />  \\
*While this is good at showing the increased value of the longer subscription, exactly how much money is charged when is unclear. This is **not** allowed.* 
{:.center}

<img src="/pictures/app-subscriptions/subscribe-buttons-good-frequency.png" width="300" />  \\
*How much money is charged when is much clearer here. This is allowed.* 
{:.center}

### You Must Be Clear About Trials

If you offer a free trial, you need to be clear about that as well.

**Important:** If the user takes up a subscription with a free trial then later cancels, if they want to re-subscribe they will **not** get a second free trial. You must reflect this in your UI so you don't end up promising a free trial that the user won't get. 

One way to do this is to fully parse your application's receipt — each subscription period will have an entry in the receipt. If you have one or more entries for your subscription's identifier and all of them have expired, the user had a subscription in the past and won't receive a free trial if they re-subscribe. 

<img src="/pictures/app-subscriptions/subscribe-buttons-with-trial.png" width="300" />  \\
*The user is eligible for a free trial, so we make it clear that they'll get a free trial and **then** they'll be charged.* 
{:.center}

<img src="/pictures/app-subscriptions/subscribe-buttons-no-trial.png" width="300" />  \\
*If the user is not eligible for a trial, we don't mention it at all.* 
{:.center}

### You Must Include The Correct Legalese 

This is the one that seems to cause the most problems, since legalese is hard and there's a lot of it. 

It's very important to Apple that it's impossible for the user to buy a subscription without seeing the legalese. This means that you can't hide it behind a "Subscription Terms" button - this would be a fork in the flow, and is **not allowed**. 

An exception to this is that you *are* allowed to have the legalese scroll off the bottom of the screen, as long as it is *completely* clear that there's more content to read, and that you're not hiding all of the legalese "below the fold".

<table>
	<tr style="background-color: transparent; border: none;">
		<td style="width: 49%;"><p class="center"><img src="/pictures/app-subscriptions/iphonese-legalese-bad.png" width="320" /><br><em>Here, the legalese is entirely hidden off the bottom of the screen. Even though the user can scroll to it, this is <strong>not</strong> allowed.</em></p></td>
		<td style="width: 49%;"><p class="center"><img src="/pictures/app-subscriptions/iphonese-legalese-good.png" width="320" /><br><em>Here, it's very clear that there's legalese to read, and that you can scroll to read more. This is allowed.</em></p></td>
	</tr>
</table>

You must also include a link to your website's Terms & Conditions, as well as your Privacy Policy, alongside your buy buttons and legalese. It *is* allowed to have these be one page.

You can find the legalese you need to include in section **3.8b** of your Paid Applications Contract. It can be a little confusing since the language is still very much aimed at magazines in places, but you should write language that makes sense for your app rather than just copy and pasting. Don't be too put off - it's possible to be very efficient with words and include everything without too much text. 

<img class="no-border" src="/pictures/app-subscriptions/iphonex-legalese.png" width="300" />  \\
*Here we can see my store page on an iPhone X, which is big enough to display everything without scrolling. The legalese paragraphs and Terms/Privacy buttons are visible here.* 
{:.center}

At the time of writing, the standard contract requires that we state the following information to users. 

**Important:** This was correct in *my* contract at the time of writing (early April 2018). You **must** check your own contract!

> **Title of publication or service**

The name of your app or subscription. Ours is **Cascable Pro**.

> **Length of subscription**

In my examples here, this is in the subtitle of the buy buttons.

> **Price of subscription**

Also in the subtitle of the buy buttons.

> **Payment will be charged to iTunes Account at confirmation of purchase**

Covered in the first paragraph of my legalese.

> **Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period** 

Covered in the first paragraph of my legalese.

> **Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal**

Covered in the first paragraph of my legalese.

> **Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user’s Account Settings after purchase** 

Covered in the first paragraph of my legalese.

> **Links to Your Privacy Policy and Terms of Use**

Green button at the bottom of my legalese.

> **Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable** 

This one is a little confusing at first, since the language seems geared towards magazines and in most apps it's impossible to buy something that would render an active subscription invalid. However, after speaking to App Review, I was advised that even if it didn't completely make sense for normal use of my app, I should include it unless I had very strong opinions about it not being there — at which point they'd have to have internal discussions about what to do. I feel like "internal discussions" means "a very long wait", so I was eager to avoid this.

Since it *is* technically possible to buy two Cascable Pro products at once if you really try hard[^1], I wrote the second paragraph of my legalese with this in mind.

### You Must Also Include Subscription Details In Your App Store Description

When submitting your app to the App Store, you must also detail your subscriptions in the same manner as in the app, including:

- A list of the subscriptions, including their durations and prices. 
- The same legalese as you put on your in-app store page.
- A link to your Terms & Conditions and Privacy Policy pages. 

Since your app's description is static content, the rules are a little more lax regarding the prices. So far, I've been fine listing the "normal" prices of the subscriptions in US dollars in all languages. You should still be able to run promotions etc without updating the price in your app description.

---

Good luck!

[^1]: Install the free version of Cascable on two devices with the same Apple ID. Purchase a subscription on the first device, then purchase a different subscription on the second without doing a "Restore Purchases". Tada! Two subscriptions. 
