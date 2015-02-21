---
kind: article
author: Daniel Kennett
created_at: '2010-04-09 14:04:05'
layout: post
slug: moonlighting-in-net-part-2-what-no-mvc
status: publish
title: 'Moonlighting in .NET Part 2: What, no MVC?'
wordpress_id: '544'
categories:
- Programming-Work
---

<p>I’m a Cocoa developer first and foremost, but for the next few months I’ll be moonlighting as a C#.NET developer, writing version 5.0 of my Music Rescue application from scratch. I actually have version 4.0 in Visual Basic.NET, but, you know — Visual Basic is for chumps.</p>
<p>Writing in C#.NET is an… interesting experience for someone used to Objective-C. This series of posts will discuss .NET from the perspective of a Cocoa developer — what’s good, bad, and just different.</p>
<p>The biggest day-to-day difference between Cococa and .NET is that, by default, you <em>don't use MVC</em>. To any Cocoa developer, the thought of not using the MVC (Model-View-Controller) pattern to build an application should be absolutely horrific. In fact, try and build a simple Cocoa app in Xcode without using MVC - it's <em>really</em> hard. I've honestly no idea why .NET/Visual Studio/etc defaults to this approach.</p><!--more--><h3>The Status Quo</h3>
<p>Visual Studio, by default, strongly encourages the use of Code Behind in the way Xcode strongly encourages MVC. When you create a window, the IDE creates a subclass of Window for you and you start adding controls to it. The events for controls (button clicks, etc) are also placed in this Window subclass by default. In the IDE, the window and the code are treated as separate items, but they get compiled down to the same class when the application is compiled.</p>
<p>This produces a huge problem if you want any kind of flexibility, or want to localise your windows and views - since the window/view and controller code are the <em>same thing</em>, you can't just load in a different window/view tuned for display in whatever language you'd like.</p>
<h3>Fixing It</h3>
<p>Since .NET provides no built-in MVC classes, I ended up writing my own window and view controller classes in <a href="http://bitbucket.org/ikenndac/knfoundation/">KNFoundation</a>, which provide the controller part of the model-view-controller pattern. They provide the standard window/view controller features as provided in Cocoa:</p>
<ul>
<li>When initiated, they look for localised versions of the given view/window name, and load in the correct one.</li>
<li>Controls placed in the view/window are automatically connected to properties in your controller subclass if they're present.</li>
</ul>
<p>They also look for a localised strings table with the same name as the view/window and attempt to apply it to the loaded view/window. See the <a href="http://bitbucket.org/ikenndac/sparkledotnet/wiki/Localizing">Localizing SparkleDotNET</a> page for an example of this at work. This is handy if you'd like to localise an item's strings but not the whole item, and is inspired by <a href="http://wilshipley.com/blog/2009/10/pimp-my-code-part-17-lost-in.html">this post</a> by Wil Shipley.</p>
<p>If you're a .NET developer and would like to try this out, check out my open-source KNFoundation library.</p>
<p>Getting the Visual Studio IDE to play along with this isn't too hard, but it is a bit tedious. Every time you create a new window or view, you need to remove the "Class" attribute from the created XAML (which is equivalent to an XIB) file to stop .NET resolving the XAML file to a class. Next, you tell Visual Studio not to compile the XAML file, but to copy it to your application's resources directory instead. Finally, you delete the generated code behind file. You only have to do this once per XAML file, but since XAML files can't contain more than one item (view, window, etc), this gets old fast! TIme to create a custom file template, I guess.</p>
<p>Loading this XAML file to a window or view is fairly simple - use the built-in XamlReader class to load in the XAML file and you'll be given back a Window or UserControl object to start working with.</p>
<p><strong>Next time: </strong>WPF, the jewel in .NET's crown.</p>