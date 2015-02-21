---
kind: article
author: Daniel Kennett
layout: post
title: "Compile-Time NSLocalizedString Key Checking"
created_at: 2014-08-10 14:45:00 +0200
comments: true
categories:
- Programming
---

There are two typical flows for using `NSLocalizedString` to localise your application's strings:

1. Type the "base" string into your source directly, then use `genstrings` to generate strings files. In your `.m` files, your calls look like this: `NSLocalizedString(@"Please enter your name:", @"String used to ask user for their name");`

2. Type a unique key into your source, then add the string for that key straight to the strings file. In your `.m` files, your calls look like this: `NSLocalizedString(@"CBLUsernameFieldLabel", nil);`

There are various merits to both approaches, and I'm not here to argue which one is best. In my world, at work we use approach #2 because our localisation process kinda requires it, and I use #2 in personal projects because, well, seeing user-facing language in `.m` files gives me the heebie-jeebies — those files are for computer language, not people language.

This post is mainly for people who use approach #2.

### Whither Error Checking?

At least once in your life, you'll have seen something like this in your projects:

<img src="/pictures/localising/missing-key.png" />
{:.center}

Even worse, if you're using approach #1, you might not notice the missing localisation until you've shipped your product and start getting complaints from customers that half your app is in English and the other half is in Spanish.

The problem is that there's no compile-time checking of strings files, and while there's a few debug tools that you can use to spot un-localised strings, in the real world these won't be run nearly as often as they should.

After *extensive* research (ten minutes of Googling) and a quick poll of Twitter (which resulted in one suggestion involving `grep`, and an argument) I couldn't really find anything like this.

### If You Want a Job Doing…

I ended up writing a little tool that takes a .strings file as an input and outputs a header file containing `NSString` constants for each key in that file. It turns this:

<img src="/pictures/localising/standard-nslocalizedstring.png" width="730" />
{:.center .no-border}

…into this:

<img src="/pictures/localising/compiled-nslocalizedstring.png" width="664" />
{:.center .no-border}

Now we have compile-time checking that my keys are present and correct, and we get autocomplete for free. Much better!

The tool is very simple, and is 80% error checking. It reads the keys in using `NSPropertyListSerialization` and writes the found keys out to a header file. You can see the source  [over on GitHub](https://github.com/iKenndac/generate-string-symbols).

### Putting It All Together

To integrate this into your project, there are three steps:

1. Generating the header files when your project builds.
2. Telling Xcode where to find the generated files at build time.
3. Importing the generate header files so you can use them.

First, you want to create a custom build step in Xcode *before* the **Compile Sources** build step to generate header files from your strings files. You could be less lazy than me and create a custom build rule to automatically do this to all your strings files, but I'm lazy. My custom build step looks like this:

~~~~~~~~
"$PROJECT_DIR/Vendor/generate-string-symbols/generate-string-symbols"
    -strings "$PROJECT_DIR/Cascable/Base.lproj/GeneralUI.strings"
    -out "$BUILT_PRODUCTS_DIR/include/GeneralUI.h"
~~~~~~~~

It uses `/bin/sh` as its shell, and I have the `generate-string-symbols` binary in the `Vendor/generate-string-symbols` directory of my project. It places the generated header file in the `include` directory of the build directory.

Next, you need to tell Xcode where to search for your files. Make sure your project's **Header Search Paths** setting contains `$BUILD_PRODUCTS_DIR/include`.

At this point, you can start using the symbols in your project. However, you'll need to `#import` your generated header files(s) in each file you want to use localised strings in.

To get around this, can `#import` them in your project's prefix header file.

In my project, I have a "convenience header" which imports the generated files and provides a couple of helper macros to make localisation a little nicer, especially considering I use non-default string table names.

~~~~~~~~
#import <Foundation/Foundation.h>
#import <GeneralUI.h> // Generated from strings file

#define CBLLocalizedString(x) NSLocalizedStringFromTable(x, @"GeneralUI", @"")
#define CBLLocalizedStringWithFormat(x, ...) [NSString stringWithFormat:CBLLocalizedString(x), __VA_ARGS__]
~~~~~~~~

…and you're done! You can find the `generate-string-symbols` project [over on GitHub](https://github.com/iKenndac/generate-string-symbols) under a BSD license. Enjoy!
