---
kind: article
author: Daniel Kennett
created_at: '2010-12-27 20:17:04'
layout: post
slug: techniques-for-managing-optional-code
status: publish
title: 'Sparkle and the Mac App Store: Techniques for managing optional code'
wordpress_id: '665'
categories:
- Programming
---

### Example 1: Managing Optional Features in Different Builds of the Same Application (like, say, Sparkle)

With the announcement of the Mac App Store, one framework has been
causing lots of trouble for a lot of people: Sparkle. Sparkle is a
framework that implements automatic updating, and is awesome —
therefore, everyone uses it. However, it directly violates the App Store
rule stating that you're not allowed to do your own updating. I made a
new build configuration that defined an "App Store build" build
variable, then had the App Store build hide those parts of the UI from
users and disable Sparkle's checking. Unfortunately, this wasn't enough!

The trick for this isn't to remove Sparkle from the App Store build —
it's to *add* Sparkle to the non-App Store build. The problem here isn't
the framework itself — simply create a new Target for your application
that doesn't include it. More tricky is managing UI — to do this, I made
a little helper class to keep things simple for my applications that may
want to use Sparkle and have a separate version for the App Store.

My technique moves all of the application's self-updating UI into a
separate nib file, which is controlled by my helper class, a subclass of
`NSViewController`:

<img src="/pictures/for_posts/2010/12/SparkleHelperXib.png" />
{:.center .no-border}

As for the helper class, allow me to present the *simplest sample code ever:*

~~~~~~~~
#import "SparkleHelper.h"

static NSString * const kSparkleHelperNibName = @"SparkleHelper";
static NSString * const kSparkleUpdaterClassName = @"SUUpdater";

@implementation SparkleHelper

-(id)init {

    if (NSClassFromString(kSparkleUpdaterClassName) == nil) {
        [self release];
        return nil;
    }

    if ((self = [super initWithNibName:kSparkleHelperNibName bundle:nil])) {
        [self view];
    }
    return self;
}

-(NSMenuItem *)checkForUpdatesMenuItem {
    return checkForUpdatesMenuItem;
}

@end
~~~~~~~~

All this does is check if the `SUUpdater` class, used by Sparkle, exists.
If it does, it loads the nib file containing my "Check for Updates..."
menu item into an `IBOutlet` and the chunk of UI to be placed into the
Preferences window into the view controller's view property. Below is
code copied and pasted from Clarus itself — applicationMenu is an
`IBOutlet` to the Application menu, and updatesView is an `IBOutlet` to a
view in the Preferences window that should contain the self-updating UI.

~~~~~~~~
SparkleHelper *helper = [[SparkleHelper alloc] init];

if (helper != nil) {

    [applicationMenu insertItem:[helper checkForUpdatesMenuItem] atIndex:1];
    [applicationMenu insertItem:[NSMenuItem separatorItem] atIndex:1];

    [updatesView addSubview:[helper view]];

    [helper release];
}
~~~~~~~~

This technique will avoid having to use compile-time \#ifdefs to change
the behaviour of the application. Simply create a target that doesn't
include the Sparkle framework and the little helper class will do the
rest. This is an incredibly simple technique, but it saves a fair amount
of effort if you ever have to do this more than once.

### Example 2: Supporting Multiple OS Versions Using Bundles

<img src="/pictures/for_posts/2010/12/ClarusTargets.png" />
{:.right .no-border} 

We've all had it. A new operating system version comes out, and we'd
really love to support X or Y new user feature in our applications.
However, what about our customers on older systems? Depending on your
userbase and attitude, this might not be an issue. However, if you've a
really large userbase, even the 5% or whatever who are still on Mac OS X
makes up a large number of people I'd like to keep happy.

The standard technique, in Xcode at least, is to set your **Base SDK**
to (say) Mac OS 10.6, and your **Deployment Target** to (say) Mac OS
10.4. That way, your app will run on 10.4 but the compiler will let you
write code for 10.6 as long as you're careful about what you use when.

Personally, I've never been a huge fan of this approach. It works
absolutely fine, but you're pretty much on your own on when it comes to
defending against calling a new API on an older OS version. You can do
all the `-respondsToSelector:` and `NSClassFromString`s you like, but I'm
always scared I'll miss something and crash.

Clarus uses one specific Mac OS 10.6-only feature: the Image Capture
API, which provides views for viewing and importing images directly from
a camera or scanner.

To achieve this, Clarus has both its **Base SDK** and **Deployment
Target** to Mac OS 10.5. However, it has a separate target with **Base
SDK**and**Deployment Target** set to Mac OS X 10.6, which is compiled
into a bundle and embedded in the Clarus application. This allows me to
have the compiler defend against using 10.6 APIs in the main application
while having a place I can write 10.6 code without restrictions or
checks all the time.

If you try to load this bundle in Mac OS 10.5, you'll get a nil bundle
and an error in the Console, so it's dead easy to check for. Since
spewing stuff into the user's console is bad (I'm looking at you,
Steam), you might like to put minimum/maximum OS versions in the
bundle's Info.plist and check them before attempting to load.

<img src="/pictures/for_posts/2010/12/KNPluginMinimumSystemVersion2.png" />
{:.center .no-border}

In code, this can then be used as needed. For example, Clarus attempts
to load all the embedded bundles present, and maintains a list of these
internally. When a piece of code, it can do a simple check and alter the
UI as needed:

<img src="/pictures/for_posts/2010/12/ClarusPluginManager.png" />
{:.center .no-border}

### Conclusion

Neither of these techniques are new or special. However, they work very
well for dealing with "optional" code in your application, which you'll
need to do if you want your application to be distributed using multiple
methods, or if you want to support multiple operating system versions
intelligently.
