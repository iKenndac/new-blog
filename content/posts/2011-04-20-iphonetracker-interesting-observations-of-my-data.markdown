---
kind: article
author: Daniel Kennett
created_at: '2011-04-20 20:56:51'
layout: post
slug: iphonetracker-interesting-observations-of-my-data
status: publish
title: 'iPhoneTracker: Interesting Observations Of My Data'
wordpress_id: '726'
categories:
- Gadgets
---

[iPhoneTracker](http://petewarden.github.com/iPhoneTracker/) came out
today, and it's a bit shocking to find out my location is being stored
on my device. Indeed, my data goes back until the day I bought by phone
in July 2010.

For a moment, I was very unnerved. I don't like the idea of my location
being stored in that much detail for so long. However, after actually
*looking* at my data (I know, right?) I'm not so outraged, but it's
still pretty bad!

### My conclusions based on cursory observation

-   The data is recording the locations of the cell towers, not yours.
-   If you don't have a data connection, locations aren't calculated.
-   Cell information isn't saved and locations calculated once you have
    data again.

### A theory on wildly inaccurate results

Figure 2, below, shows locations in Sweden I've never been anywhere near
in my life - mainly the ones down the west coast and southeast coast
away from the big clumps.

I once visited a hotel with free WiFi. My iPad, only having WiFi to base
its location on, put my position smack on a Travelodge hundreds of mies
away. Turns out the base station used was moved from that Travelodge and
the location never updated.

I wonder if the same happens here? It doesn't seem implausible that cell
towers are moved around without having their location updated in the
relevant database.

### My opinion

Location data is an *incredibly* personal thing. Coupled with a
timestamp, you can infer all sorts of things about a person, and there
have been several projects that can predict the location of a person
based on historical location information like this. That they seem to be
collecting cell tower data as opposed to your own location makes this
less bad, but Apple *really* need to make it *crystal* clear to users
that they're storing this information in cleartext all the time they're
using their phones.

I'm not against the collection of this data at all. I understand that
this sort of data is recorded all the time, either on the handset in
question or by the networks themselves. My beef is that this data is
being saved, seemingly permanently, **unencrypted** and in plain view
for anyone to see, **without telling me.** It may well be buried in the
license agreement nobody reads through, but that's not really an excuse.

### Interesting parts of my location history

<img src="http://ikennd.ac/pictures/for_posts/2011/04/iPhoneLocationDataGermany.png" />
{:.center}

**Figure 1:** Driving through Germany. We stayed overnight down near
Belgium, then drove through Germany the next day before arriving near
Hamburg for another overnight stop. I had Data Roaming switched on for a
while at our stopovers, and occasionally switched it on throughout the
drive to check Twitter.

<img src="http://ikennd.ac/pictures/for_posts/2011/04/iPhoneDataSweden.png" />
{:.center}

**Figure 2:** Driving through Sweden. My data is on permanently in Sweden,
of course, so the are a lot more cell towers here. There's a very
interesting hole in the data towards the South, which isn't a one-time
thing — this data was collected over three separate trips through the
country: one in August 2010, the other two in March 2011.

<img src="http://ikennd.ac/pictures/for_posts/2011/04/iPhoneDataFerry.png" />
{:.center}

**Figure 3:** Sailing past England. This data is from two separate trips,
both in March 2011, on a ferry from Denmark to the UK. The ferry sailed
along the British coast before heading over the North Sea to Denmark.
