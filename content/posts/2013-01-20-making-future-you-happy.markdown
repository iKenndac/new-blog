---
layout: post
kind: article
author: Daniel Kennett
title: "Making Future-You Happy: Figuring Out How To Organise and Tag Your Photo Library"
slug: making-future-you-happy
created_at: 2013-01-20 21:14
comments: true
categories:
- General
---

My Aperture library is over 15,000 photos strong, which isn't *huge*, but it's enough photos to make proper storage and tagging important. 

My Aperture library is organised by Category, then by year (maybe), then by "event". For example...

* Events
    * 2010
    * 2011
    * 2012
* Holidays and Trips
    * 2012
        * WWDC 2012
* People and Things
    * House

This seemed like a good idea to start with, but it's actually fairly terrible. For example, I want a photo from WWDC 2012. Is that in *Events* or *Holidays and Trips*? I mean, it's a "trip" for me, but WWDC is actually an event! This wishy-washy organisation isn't so helpful when you're trying to find photos from years ago. This, coupled with a complete lack of manual tagging, is a pain to work with.

## A Fresh Start ##

After my previous [post](http://ikennd.ac/blog/2012/12/the-educated-fanboy-aperture-vs-lightroom/) discussing Adobe Lightroom, not *three weeks ago*, basically concluded that I prefer Aperture, well, I've decided to slug it out a bit longer with Lightroom and do a long-term test.

On January 1st 2013, after waking up in the afternoon and noting that 2013 was in no was different to 2012, I launched Lightroom and pressed the "New Catalog" button. Starting then, I'd be using Lightroom for all of my photography work instead of Aperture, something I wasn't sure would be a smart idea considering I didn't actually like the program all that much. (I've since come to like Lightroom much more, but that's for another post).

[<img src="http://pcdn.500px.net/22000369/e080bb38658c1ffecac817d15c3d50014b36d1a0/4.jpg" />](http://500px.com/photo/22000369) \\
 *New year, New photo library!* 
{:.center}

With this fresh new start, I'm determined to start and keep up with a photo library that allows me to find my photos reasonably quickly and with as little frustration as possible. My library should meet the following criteria:

1. I shouldn't be spending more than a few seconds per photo on import to get the metadata to a state of meeting the rest of these criteria.

2. A good portion of it should be automatable, if possible.

3. The metadata should allow me to, in the future, filter down my library to a reasonable number of candidates for the photo I'm actually looking for. 

4. The data input for each photo must conform to a defined schema to keep metadata consistent.

My rationale behind the first entry is that if metadata input takes too long, I won't bother doing it. The second entry helps the first become more of a reality. The third is a realisation of the first two — if my metadata entry isn't taking very long, it won't be *that* comprehensive, but if I can filter my 15,000 photos down to 150 candidates I'll be able to find the photo I'm looking for manually in not too much time. 

The last entry is to try and combat "tag creep". I've seen this a lot, especially on blogs, where people just type in tags as they pop into their head. For example, in the photo above, well, it's **night**. And there are **fireworks**. Oh, and **trees**. And **clouds**! **night, fireworks, trees, clouds** actually seems like a reasonable set of tags. However, my next fireworks shot is on the next night and there's only one **firework** and it's a **starry** night. **night, firework, trees, starry**. The only two tags those photos have in common are **night** and **trees**, neither of which are material to the photos! Clearly, we need a well-defined way of tagging photos.

## It's all about the questions! ##

Earlier this evening, I [tweeted](http://twitter.com/iKenndac/status/293052592366419968) asking others how they organised their libraries, and quickly learned that everyone is different, and nobody seems to have a catch-all solution.

So, I started thinking about what I should tag my photos with and didn't get far. *Then*, I started thinking about how I try to find photos once they're in the library. That's when I started getting somewhere — and I started listing all the questions I ask myself (and my photo library software) when trying to find my photos. Then I remembered that damnit, if I'm putting this effort into cataloging my library, the computer should be asking *me* the questions!

This brainwave has completely flipped how I think about metadata — **it isn't for finding the photo you want, but for dismissing the photos you don't want**. 

The list below isn't the questions I ask my computer to find photos — it's the questions I want the computer to be able to ask *me* to get rid of the photos I'm not interested in:

### Where did you put the photo on disk? ###

I'll get this out of the way quickly — when trying to find photos, I *never* think about my computer or any detail of it. Therefore, I don't care where my photos are on my computer. I let Aperture/Lightroom deal with them as they'd like to, and make sure I have backups. Hard drives, folders and filesystems are things for computers to deal with, not me. Therefore, I don't use custom folder names or anything crazy like that.

### What did you name the photo's file? ###

Similar to my previous point, filenames have no hope of being helpful and I never think about them. There's no way they can contain enough information to be useful, and one day you'll encounter a USB stick formatted as FAT16 and you won't be able to put your crazily-named files on it. I'll let my computer deal with that and not care myself.

### When did you take the photo? ###

Thankfully, assuming you have your camera's clock set correctly, this is a non-issue. Time and date metadata is already present in my photos. Hooray!

### Where did you take the photo? ###

Location, in my opinion, is one of the most important pieces of metadata a photo can have, even if it's not that accurate. Hell, *especially* if it's not that accurate! For example, I remember seeing an awesome car when I was a kid somewhere in France. That's enough information (**France**, **1985 - 1995**, **Car**) to filter out 99% of my library!

I already geolocate my photos in two ways — if I was out and about snapping away I'll manually geolocate as best as I can when I return. Even if I find a year-old picture on some motorway in Germany, I'll geolocate it to **Germany** and be done with it. 

If I'm going on a photo walk — that is, a walk or similar with an express intent to take photos along the way - I'll bring my [bike's GPS](http://ikennd.ac/blog/2012/04/high-tech-meets-low-tech-gps/) with me. It's a Garmin Montana, and I specifically chose that rather expensive model because the battery lasts up to 16 hours. I can switch it on, throw it in my backpack and when I get home I have a trace of where I've been all day. Both Aperture and Lightroom contain tools to link this trace to your photos, automatically and accurately geotagging the day's photos in an instant.

### What is in the photo? ###

This one is a bit more difficult. Photos always contain *lots* of things. The photo above contains fireworks, the sky, clouds, trees, people, street lamps, buildings, snow, gravel, probably a mouse hibernating under a bush somewhere (Note: mice probably don't hibernate in bushes), a bench, etc etc etc.

*However*, I never care what's in the photo when looking for it. I care what the photo is *of*, and that photo is of fireworks. However, as discussed above, telling the computer what the photo is *of* can quickly get messy. 

Instead, I've decided to distill this question down further, to a simple yes/no question:

**Is the photo of a ______ ?**

This way, tags can always be singular. Is the photo of a **firework**? Is it of a **tree**?

### What environment was the photo taken in? ###

Sometimes, I want to find some pictures I know were taken at night, or in the snow, or both. Adding a tag for this would be useful!

## Browsing ##

Sometimes, rather than searching for specific photos, I want to browse through all of the photos I took at, for example, WWDC 2012. In addition, I often keep a photo reference of progress on various projects such as my [railway](http://ikennd.ac/blog/2012/10/winter-project-model-railway/) or [robotic monster truck](http://ikennd.ac/blog/2011/10/where-the-hell-is-my-self-driving-car/).

To allow this, I'll continue to organise my photos by year, but rather than vague top-level folders I'll stick with three: **Projects**, **Events & Trips** and **Photography**, the latter reserved for photos where the sole point of taking the photo was to make a beautiful photo.

Additionally, sometimes I want to browse (or share) my favourite photos, either because they're photos I'm proud of technically or they just remind me of something amazing. For this, I'll use the star rating system — typically photos in my library are ★★★★★ or nothing.

[<img src="http://pcdn.500px.net/8718249/e9601f6b6f087f6783ebef4d0ba7a9361cfdadb4/4.jpg" />](http://500px.com/photo/8718249) \\
 *"Port of San Francisco", a photo I consider ★★★★★.* 
{:.center}

## The Metadata Schema ##

Based on these questions and the above criteria, I've settled on the following metadata schema on top of the metadata already added to the photo by the camera:

* Location, as accurately as possible.
* **One** tag for the environment (examples: **Indoors**, **Snow**, **Rain**).
* **One** tag for the subject matter unless it's a photo of people, which must be singular (examples: **Plane**, **Car**, **Landscape**).
* **One** tag **per primary person** in the shot (examples: **Tim**, **Chester**, **Me**).
* If the photo was taken at night, the tag **Night**.

This metadata schema is quick to enter and will allow me to filter down my library fairly accurately based on the questions I typically ask when searching for photos. It's also intentionally very restrictive to avoid tag creep — I don't want to be entering twenty tags per photo in a year's time as I slowly start adding more things in.

As for whether this will work, well, only time will tell. It can't be worse than it was before, right?
