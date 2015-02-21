---
kind: article
author: Daniel Kennett
layout: post
title: "Compile-Time NSLocalizedString Key Checking Part 2: Other Languages"
created_at: 2014-08-25 20:00:00 +0200
comments: true
categories:
- Programming-Work
---

In my last post, [Compile-Time NSLocalizedString Key Checking](/blog/2014/08/nslocalizedstring/), we explored a solution that elevated `.strings` files from "just another resource" to something that we could get compile-time checks on.

However, these checks only worked on our "master" `.strings` file — the one strings get added to first, typically in `Base.lproj` or your local development language.

This becomes a problem sometimes as I'm working in a flow like the one diagrammed below.

<img src="/pictures/localising/workflow.png" />
{:.center .no-border}

Translations take a while to get done - perhaps a week or more. In the meantime, I'm working on other things and sometimes updating the code for the feature that's getting translated in a way that means the strings need to be updated.

Since this process is very asynchronous, we quite often bump into problems caused by out-of-sync translations while testing. This is normally not too much of an issue, but it's a waste of everyone's time if we give a build to a tester in another country and get a report back that some translations are missing.

Since we're working with *huge* amounts of strings and with a third-party localisation service that isn't integrated into Xcode at all, manually diffing `.strings` files is a pain, and is really a problem that should be dealt with by the computer.

### The Solution ###

A picture tells a thousand words.

<img src="/pictures/localising/missing-strings-error.png" />
{:.center .no-border}

`verify-string-files` is a little tool I wrote (and is [available on my GitHub](http://github.com/ikenndac/verify-string-files)) that emits warnings or errors if a string is present in the "master" `.strings` file but is missing from any localisations.

Usage is very similar to my tool that generates header files from `.strings` files, but a bit simpler - it takes a single input file, the "master" file, and automatically finds matching localised files.

To integrate it with your Xcode project, add a custom build step at any sensible point in the build process that runs the following script:

~~~~~~~~
"$PROJECT_DIR/Vendor/verify-string-files/verify-string-files"
    -master "$PROJECT_DIR/Cascable/Base.lproj/GeneralUI.strings"
~~~~~~~~

It uses `/bin/sh` as its shell, and I have the `verify-string-files` binary in the `Vendor/verify-string-files` directory of my project.

The tool will output log messages if it finds any problems, and Xcode will pick them up and display them just like my screenshot above. If you want the tool to output warnings instead of errors, add the `-warning-level warning` parameter to `verify-string-files` — a useful thing to do is have the tool emit warnings when debugging but emit errors if you try to make a release build with missing strings.

<img src="/pictures/localising/missing-strings-warning.png" />
{:.center .no-border}

You can find the `verify-string-files` project [over on GitHub](https://github.com/iKenndac/verify-string-files) under a BSD license. Happy localising!
