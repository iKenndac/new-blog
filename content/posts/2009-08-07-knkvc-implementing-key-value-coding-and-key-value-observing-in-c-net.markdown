---
kind: article
author: Daniel Kennett
created_at: '2009-08-07 21:34:08'
layout: post
slug: knkvc-implementing-key-value-coding-and-key-value-observing-in-c-net
status: publish
title: KNKVC - Implementing Key-Value Coding and Key-Value Observing in C#.NET
wordpress_id: '398'
categories:
- Programming
---

**Note:** This is full-on, hardcore *Computer Science* right here. If
you're here to read about [my cute doggie](/blog/2009/02/goggie/) or how I'm the [best boyfriend ever](/blog/2009/05/romance-and-nerdiness-the-perfect-couple/), this post isn't for you.

**Want the code first?**

Head over to the [KNKVC page](http://www.kennettnet.co.uk/code/KNKVC/) of my company's site to
download it. 

I'm an Objective-C/Cocoa programmer by heart, but because
of my job I also regularly program on Windows. Now, since I'm a Mac
developer you're probably expecting me to harp on about how Windows
programming is soul-destroying and crappy and blah blah blah. Well, no.
If you're doing the *right* kind of programming, it's exciting and
interesting no matter what platform you code on. In fact, if anything
the satisfaction of coding something awesome on Windows has a greater
feeling of accomplishment at the end because the bar is set so low in
the Windows software field. When do you something truly great it stands
head and shoulders above the rest. My favourite kind of programming is
framework programming. Designing a component outside of the complexities
of a whole application allows you to design beautiful, clean APIs and
components. In fact, every single application I write or am a part of
writing ends up shipping in components. Music Rescue for Windows, for
instance, has a library for talking to iPods which I wrote, a library
containing user interface controls which I wrote and the application
(which my colleague wrote) imports them both and assembles it all
together into an application.

### Shameless Copying

When I first started working in .NET, it became very clear very quickly
that it wouldn't be as easy as the Mac version. The main problem being
the the built-in table control is absolutely *terrible*, and Music
Rescue is pretty much all tables. Every time I saw something I disliked
in .NET, I'd exclaim "*Cocoa does this much better!*". Some of the time
is was down to preference, but others (like the table) the .NET version
simply wouldn't do. Eventually, I started implementing bits of Cocoa in
.NET. First came the token field, then the table view and its supporting
classes (cells, columns, etc etc). One of the greatest things in the
Cocoa Framework, though, is Key-Value Coding (KVC) and Key-Value
Observing (KVO). Key-Value Coding allows you to get and set values of
objects without actually caring what they are. It provides nifty little
features when combined with arrays and dictionaries. Say you have an
array of chairs. Want a list of the chairs' colours?
`chairArray.valueForKey("colour");` gets you that list. Key-Value
Observing allows you to be notified when a property of a particular
object is changed. For example, if you want to know when the number of
legs your chair has changes (perhaps one breaks off?), add yourself as
an observer to the legs property of the chair and you'll automatically
be told when that value changes. This is an *amazing*tool if used
properly, and severely reduces coupling. In fact, Key-Value Observing
has made the model *so* separate from the rest of the app in Clarus, the
entire model is in a separate assembly and I don't subclass once in the
application.

### How does it work? Magic, right?


<img src="/pictures/for_posts/2009/08/KNKVCProjectSml.PNG" />
{:.right .no-border}

Three things made me attempt to implement KVC/O in .NET...

1. For ages I've pondered how Key-Value Observing in Cocoa works. I get
about 90% of it, but how does it *automatically* know when the properties
are changed? I don't do anything special - just set an iVar.

2. I've become so used to KVC and KVO, I find it hard to write code without
them.

3. I should really get round to learning C\#. Visual Basic is
great, but annoyingly restrictive at times. So, how better to learn a
brand new programming language than by implementing something I don't
understand? Great!

### The Nitty Gritty

First, KVC. KVC is pretty easy to implement, to be honest, and the
entire KVC system is only around 400 lines of C\#. I declare a couple of
extension classes to the Object - one for getting and the other for
setting, just to keep it separate. When you call `valueForKey`, it simply
uses `System.Reflection` to look for a property for that key and invokes
the getter to retrieve the value. If a property isn't found, we look for
a method that returns a value with the same name as the key. If *that*
doesn't work, we call `valueForUndefinedKey` to throw an exception or do
whatever custom logic subclasses might want to do. Setting is more or
less the same story, but if a property can't be found we look for a
method called `set<Key>` that takes a single parameter and call that.
Finally, I implement a few specific extension methods for arrays and
dictionaries to get that juicy feature set I was speaking about.

### KVO

KVO is harder and more complex. The line count isn't much higher -
around 440 lines of C\# but they're 440 *hardcore* lines, unlike the KVC
implementation that's mostly full of null checking. Unfortunately, it's
not simple enough to describe succinctly with words. Allow me to
present... a *diagram*:

<img src="/pictures/for_posts/2009/08/KNKVO-Path-Flow.png" />
{:.center .no-border}

At the moment, let's just pretend the automatic stuff actually works and
`KNKVOCore` gets notifications of then a property is about to change and
when it has changed. Using these notifications, it looks through the
list of `ObservationInfo` objects and if the key and object match, tells
them that their property will or has changed. In turn, the
`ObservationInfo` object, depending on the options set by the observer,
sends out change notifications. Each `ObservationInfo` is responsible for
one observation of an object by an observer.

At the moment, this is all very simple. However, it gets complicated
when we start dealing with key *paths*. A key path is a trail through an
object tree, and look very much like dot notation in Java or C\# or
whatever. So, let's say we want to observe `house.kitchen.drawer.utensilCount`.
Easy, right? We just `valueForKey` our
way down to `drawer` and observe `utensilCount`, right? Fine, but what
happens if someone *else* says `kitchen.drawer = new drawer()`?
Suddenly, the drawer instance we're observing isn't the same as
`house.kitchen.drawer`, and our observation is now either observing the
wrong thing, or observing nothing since memory management deallocated
the object. What we need to do is observe every single step of the key
path for changes, and when items change, remove the observer from the
old value and add it to the new one. All this happens under the hood
since the client doesn't care about what kitchen the house has, or what
drawer it has - just how many utensils are in the house's kitchen's
drawer. Enter `KNKVOKeyPathObserver`. When the client wants to observer
a key *path*, `KNKVOCore` creates one of these bad boys instead of an
`ObservationInfo`. The `KeyPathObserver` then runs through the key path,
observing each part of the path on the relevant object, for which
`KNKVOCore` creates an `ObservationInfo` as discussed before. When it
receives a change notification from any of its objects, it removes its
observers from the entire tree of old objects and adds new observers to
the new tree, sending change notifications back to the *original*
observer as needed.

### Automatic?

Up until now we've been assuming that `KNKVOCore` can get notifications
just before and after properties of objects change. This isn't so easy
in C\#.NET. The Cocoa version of KVO allows you to manually specify when
you're going to change a value: 

~~~~~~~~ objc
[self willChangeValueForKey:@"name"];
// Some really complex logic to determine a new name
[self didChangeValueForKey:@"name"];
~~~~~~~~

I've implemented this in my version as
well, so currently properties have to do a similar thing to get noticed
by `KVOCore`. Which is totally lame, since I can't modify all the
properties in existing .NET classes. The next solution is to add those
will/didChange... calls into the `setValueForKey` methods. This is *less*
lame because I can call `setValueForKey` on anything. However, all the
other classes aren't going to use those, so I can only observe when *I*
change they keys, which is dumb since I *know* that the value changed,
because I just changed it. See?

The next solution is to use .NET's `INotifyPropertyChanging` and
`INotifyPropertyChanged` interfaces, but
barely anything actually uses them. 

Next! 

The *next* solution is to get
clever with *Reflection.Emit*. Using *Reflection.Emit* allows you to
dynamically override methods, but unfortunately you have to create a
dynamic subclass to do so, rendering this approach useless as well - I
want auto-KVO on existing instances, not new ones. Next, we find
PostSharp. PostSharp is an aspect-based framework, allowing the
injection of methods that get called just before and just after the
target method. This is perfect! Unfortunately, PostSharp does this
either on compile or load time, meaning we can't do it dynamically at
run time. Damnit! 

...and that's it. I've now run out of solutions.
Microsoft are currently testing .NET 4.0, which promises more
dynamic...ness, including dynamic dispatch. Hopefully that'll allow me
to implement automatic KVO, but since I'd like to release the next
update to my app before the end of 2010 I might be using manual KVO in
my next .NET project (Music Rescue 5.0).

### What Now?

Well, I release some code, of course! Although it's not working as
automatically as I'd like, this has been a great technical exercise, and
one of the most difficult problems I've tackled in programming -
especially the implementation details of observing a key path. I've
learned how KNO *isn't* actually magic, and although I doubt my
implementation of it is a great as the one in Cocoa, it works well
enough to be useful in shipping products. Hell, this'll be an integral
part of Music Rescue 5.0, automatic or not! You can find the KNKVO code
and documentation over at the [open-source section](http://www.kennettnet.co.uk/code/KNKVC/) of my company's
website.
