---
kind: article
author: "Daniel Kennett"
layout: post
title: "Editing, Previewing and Deploying nanoc Sites Using An iPad"
created_at: 2019-02-03 18:00:00 +0100
categories:
- General
- Programming
published: true
---

For the first time in this blog's history, I am going to try my very best to write, edit, polish and deploy a post using only an iPad (sort of). I'll  let you know if I was successful at the end.

<img src="/pictures/nanoc-on-ipad/nanoc-on-ipad.jpg" />  \\
*Unfortunately, the power button on the iMac G3's keyboard does nothing on an iPad.* 
{:.center}

The unfortunate reality of the iPad right now (in early 2019) is that for many workflows, it simply isn't viable as a replacement for a "real" computer. Even those with workflows that an iPad *can* do and that have managed to make the switch to it stick, allow us to modify an old joke:

> How do you know if someone uses an iPad as a laptop replacement? Don't worry — they'll tell you! 

This isn't to belittle their achievements — building a viable workflow for any serious task that requires more than one app on the iPad is a real challenge, and people are damn right to be proud of their collections of [Shortcuts](https://support.apple.com/guide/shortcuts/welcome/ios) and URL callback trees.

However, slowly but surely the iPad is getting there. Personally, the 2018 iPad Pro crossed over the line for me for a couple of reasons, and for the first time in the iPad's history, it's a computer I want to carry around with me and use for "real" work.

### Development Hell

Unfortunately for me, I'm a developer. Because of that, when I see a problem, I come up with a developer solution. Most people have been able to write articles for their blog on their iPad for years - they just log into Squarespace, Wordpress, or whatever else they've chosen in Safari and write away. 

My blog, however, uses [nanoc](https://nanoc.ws). Nanoc is a program that takes a pile of files, processes them, and spits out another pile of files that happens to be a website. I then upload this pile of files to my webserver, and my article is live!

To do this, I simply open my terminal, `cd` into the directory of my blog, then run `bundle exec nanoc` to generate... and we can see why this doesn't work on an iPad.

### Developer Solutions to Developer Problems

So, what do I really want to do here? I want to be able to:

1. Write blog posts on my iPad.

2. Preview them on my iPad to check for layout problems, see how the photos look, make sure the links are correct, etc.

3. Once I'm happy with a post, publish it to my blog.

Step one is easy enough - I find a text editor and type words into it. However, step two is where we fall over hard. Many editors can preview Markdown files, but they only preview them "locally" - they don't put the preview into my website's layout, won't display photos, and generally won't parse the custom HTML I put into my posts sometimes.

To achieve this, we really need to be able to put the locally modified content through `nanoc` and display the output through a HTTP server. This is easy peasy on a traditional computer, but not so on an iPad. 

So, here's why I'm only *sort of* writing this post using an iPad — while I am sitting here typing this post on an iPad, I have a computer elsewhere helping me along a little bit. My solution has:

- A continuous integration (CI) server watching my blog's repository for changes, then building my blog with `nanoc` for each change it sees.

- A static web server set up to serve content from a location based on the subdomain used to access it.

So, as I'm writing this, I'm committing the changes to a branch of my repository - let's say `post/nanoc-on-ipad`. Once I push a commit, my CI server will pick it up, build it, then deploy it to the web server. I can then go to `http://post-nanoc-on-ipad.static-staging.ikennd.ac` to view the results. It's not quite a *live* preview since my blog is ~400Mb of content and the build server takes a minute or two to process it all, but it's enough that I can write my blog post with Safari in split view with my editor, and I can reload occasionally to see how it's going.
