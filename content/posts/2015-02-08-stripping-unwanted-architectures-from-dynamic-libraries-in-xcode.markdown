---
kind: article
author: Daniel Kennett
layout: post
title: "Stripping Unwanted Architectures From Dynamic Libraries In Xcode"
created_at: 2015-02-08 19:00:00 +0100
comments: true
categories:
- Programming-Work
---

Since iOS 8 was announced, developers have been able to take advantage of the benefits of dynamic libraries for iOS development.

For general development, it's wonderful to have a single dynamic library for all needed architectures so you can run on all your devices and the iOS Simulator without changing a thing.

In my project and its various extensions, I use [Reactive Cocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) and have it in my project as a precompiled dynamic library with `i386` and `x86_64` slices for the Simulator, and `armv7` and `arm64` for devices.

However, there's one drawback to this approach - because they're linked at runtime, when a dynamic library is compiled separately to the app it ends up in, it's impossible to tell which architectures will actually be needed. Therefore, Xcode will just copy in the whole thing into your application bundle at compile time. Other than the wasted disk space, there's no real drawback to this in theory. In practice, however, iTunes Connect doesn't like us adding unused binary slices:

<img src="/pictures/iTC-Unsupported-Archs.png" width="614" />
{:.center .no-border}

So, how do we work around this?

- We could use static libraries instead. However, with multiple targets and extensions in my project, it seems silly to bloat all my executables with copies of the same libraries.

- We could compile the library from source each time, generating a new dynamic library with only the needed architectures for each build. A couple of things bother me about this - first, it seems wasteful to recompile all this non-changing code all the time, and the second is that I [like to keep my dependencies static](/blog/2015/01/secret-diary-of-a-side-project-part-2/), and making new builds each time means I'm not necessarily running stable code any more, particularly if I start mucking around in Xcode betas. What if a compiler change causes odd bugs in the library? It's a very rare thing to happen, but it *does* happen, and I don't know the library's codebase well enough to debug it.  

- If we don't have the source to start with, well, we're kinda out of luck.

- We could figure out how to deal with this at build-time, then never have to think about it again. This sounds more like it!

### Those Who Can, Do. Those Who Can't, Write Shell Scripts

Today, I whipped up a little build-time script to deal with this so I never have to care about it again.

In my project folder:

~~~~~~~~
$ lipo -info Vendor/RAC/ReactiveCocoa.framework/ReactiveCocoa

→ Architectures in the fat file: ReactiveCocoa are:
    i386 x86_64 armv7 arm64
~~~~~~~~

After pushing "build":

~~~~~~~~
$ lipo -info Cascable.app/Frameworks/ReactiveCocoa.framework/ReactiveCocoa

→ Architectures in the fat file: ReactiveCocoa are:
    armv7 arm64
~~~~~~~~

Without further ado, here's the script. Add a **Run Script** step to your build steps, put it after your step to embed frameworks, set it to use `/bin/sh` and enter the following script:

~~~~~~~~ bash
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
    FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
    FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
    echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

    EXTRACTED_ARCHS=()

    for ARCH in $ARCHS
    do
        echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
        lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
        EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
    done

    echo "Merging extracted architectures: ${ARCHS}"
    lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
    rm "${EXTRACTED_ARCHS[@]}"

    echo "Replacing original executable with thinned version"
    rm "$FRAMEWORK_EXECUTABLE_PATH"
    mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

done
~~~~~~~~

The script will look through your built application's `Frameworks` folder and make sure only the architectures you're building for are present in each Framework.

<img src="/pictures/iTC-Success.png" width="614" />
{:.center .no-border}

Much better! Now I can throw fat dynamic libraries at my project that contain all the architectures I'll ever need, and my build process will deal with which architectures are appropriate at any given moment.
