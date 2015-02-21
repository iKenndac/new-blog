---
kind: article
author: Daniel Kennett
layout: post
title: "Compile-Time Image Name Checking"
created_at: 2015-01-10 21:40:00 +0100
comments: true
categories:
- Programming-Work
---

In my [continued](http://ikennd.ac/blog/2014/08/nslocalizedstring/) [quest](http://ikennd.ac/blog/2014/08/nslocalizedstring-part-2/) to banish as many string literals as I possibly can from my project, I wrote a little tool to generate a header file containing string constants for the names of all the images in my `.xcassets` bundle. 

This means you get compile-time checking of two things — you misspelling the image name, and images being named incorrectly.

<img src="/pictures/image-symbols.png" width="590" />
{:.center .no-border}

The tool is very simple, and is mostly a duplicate of the `generate-string-symbols` tool I wrote a while ago. It runs through your `.xcassets` directory and writes the found image names out to a header file. You can see the source over on [GitHub](https://github.com/iKenndac/generate-imageasset-symbols).

For consistency's sake, you can pass `-prefix` and `-suffix` parameters to the tool, which do what they say on the tin. A prefix of `CBL` and a suffix of `ImageName` will convert and image named `Awesome` into `CBLAwesomeImageName`, with a value of `@"Awesome"`.

### Putting It All Together

To integrate this into your project, there are three steps:

1. Generating the header files when your project builds.
2. Telling Xcode where to find the generated files at build time.
3. Importing the generated header files so you can use them.

First, you want to create a custom build step in Xcode *before* the **Compile Sources** build step to generate header files from your image assets. My custom build step looks like this:

~~~~~~~~
"$PROJECT_DIR/Vendor/generate-imageasset-symbols/generate-imageasset-symbols" 
    -assets "$PROJECT_DIR/Cascable/Images.xcassets"
    -out "$BUILT_PRODUCTS_DIR/include/CBLImageNames.h"
    -prefix CBL
    -suffix ImageName
~~~~~~~~

It uses `/bin/sh` as its shell, and I have the `generate-imageasset-symbols` binary in the `Vendor/generate-imageasset-symbols` directory of my project. It places the generated header file in the `include` directory of the build directory.

Next, you need to tell Xcode where to search for your files. Make sure your project's **Header Search Paths** setting contains `$BUILD_PRODUCTS_DIR/include`.

At this point, you can start using the symbols in your project. However, you'll need to `#import` your generated header files(s) in each file you want to use localised strings in.

To get around this, can `#import` them in your project's prefix header file.

~~~~~~~~
#import <CBLImageNames.h> // Generated from image assets

UIImage *image = [UIImage imageNamed:CBLAwesomeImageName];
~~~~~~~~

…and you're done! You can find the `generate-imageasset-symbols` project [over on GitHub](https://github.com/iKenndac/generate-imageasset-symbols) under a BSD license. Enjoy!
