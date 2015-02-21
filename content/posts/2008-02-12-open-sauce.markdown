---
kind: article
author: Daniel Kennett
created_at: '2008-02-12 00:54:27'
layout: post
slug: open-sauce
status: publish
title: Open Sauce
wordpress_id: '45'
categories:
- Programming-Work
---

Over the past few days, I've been writing Mac (Cocoa) and Windows (.NET) code to allow the new version of a certain <a href="http://www.kennettnet.co.uk/musicrescue">product</a> of mine to work with those new-fangled ((iPhone was released in the US in June 2007 - 8 months ago. Ahem.)) iPhones and iPod touches we've been hearing so much about. 

And, to be honest, it's been a pain in the backside. Since the iPhone/iTouch doesn't mount itself on the filesystem, you can't get at it easily like the other iPods. Instead, you've got to talk to it using a special protocol. This in itself isn't a problem, but the protocol is proprietary. Therefore, you have to link into Apple's undocumented driver and talk to it through that.

At first, I was apprehensive about such a thing, before I remembered that the iPod's database format is <em>also</em> proprietary, and I've been mucking around that with gay abandon for years. Also, I'm actually using the same library that iTunes uses to get data from the iPhone, so it's fairly ((If you ignore the fact I'm linking into a private, undocumented API that can change at any time.)) safe. 

So, after a day at work and an evening at home, I have this:

<a href='http://ikennd.ac/pictures/for_posts/2008/02/phonebrowse.jpg' title='Browsin’ Up A Storm'><img src='http://ikennd.ac/pictures/for_posts/2008/02/phonebrowse.jpg' alt='Browsin’ Up A Storm' /></a>

A fully functional ((It's not fully functional at all. It works - a bit.)) iPhone/iPod Touch browser! 

<!--more-->

Now, this isn't all me. There's an <em>amazing</em> community that's done most of this - I've just taken what they've done and made a pretty framework on top of it, porting the straight C++ code into Objective-C goodness with lots of lovely features on top. Want a file from the device? Instead of dealing with <code>char *</code> buffers, you can just use 
<code>-(NSData*)contentsOfFileAtPath:(NSString *)path;</code> instead. Don't want that 2Gb file in memory all at once? Sure - just use <code>-(NSData *)readFromFile:(unsigned long long)rAFC size:(unsigned int *)size offset:(off_t)offset;</code> instead. 

Now, since this is all based on community effort, it'd be wrong of me to use the work done and not give back. So, in a week or two when I've added more stuff, tested and documented, I'll be releasing my iPhone/iPod touch frameworks in Cocoa and .NET back to the community as open-source. I'm actually quite looking forward to it - this is the first bit of programming I've done that a) I think will be useful to the community and b) my company can release without worrying about the damage it'll do to my income! 