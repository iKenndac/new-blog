---
kind: article
author: Daniel Kennett
created_at: '2008-02-21 23:44:01'
layout: post
slug: three-wasted-hours
status: publish
title: Three wasted hours!
wordpress_id: '57'
categories:
- General
---

Ok, so you've upgraded your home server machine to Mac OS X 10.5 Server from 10.4 for all those lovely new features. You go to mount your music share so you can listen to some kickin' tunes... and nothing. Login denied. 

... 30 minutes later, and you're sure it's something to do with the way the new Open Directory/LDAP authentication works, and how AFP isn't talking to it properly. 

... two hours later, you've tried all the configurations of LDAP and search policies you can think of.

Three hours later, you decide to read the log file. "SACL authorisation failed", it says. Hrm. To the access control! Wait, my name isn't that UUID! 

<a href='/pictures/for_posts/2008/02/picture-1.png' title='Broken User'><img src='/pictures/for_posts/2008/02/picture-1.png' alt='Broken User' /></a>
{:.center}

<!--more-->

That'd be the UUID of the old user before the upgrade. How many clicks can I fix this in? One? (Clicks "Allow all users and groups"). Nope. Two? (Clicks "Save")... 

<a href='/pictures/for_posts/2008/02/picture-2.png' title='Felicity Shares'><img src='/pictures/for_posts/2008/02/picture-2.png' alt='Felicity Shares' /></a>
{:.center .no-border}

YES!

Total time spent fixing... three seconds. *Sigh*

Still, now I can listen to some kickin' tunes while my computers back up my stuff. 