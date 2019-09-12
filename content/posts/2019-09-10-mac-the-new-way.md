---
kind: article
author: "Daniel Kennett"
layout: post
title: "Programming on the Mac: The New Way"
created_at: 2019-09-10 08:00:00 +0200
categories:
- General
---

Part 1: Overcoming Technical Limitations 
Part 2: Overcoming Policy (App Store Review)

(Part 2: Policy will overcome tech - giving yourself an entitlement to read the whole drive will most likely get you rejected.)

---

Let's run over a typical start-to-finish 

#### Getting Connected

Either:

- Scan a camera's QR code using the Mac's webcam, then switch the Mac's WiFi network over
- If the user has "Launch when joining these networks" enabled, have a background helper launch Cascable Transfer when the user manually joins the camera's network.

#### Copying Images

Either:

- Copy images to a folder chosen by the user.
- Copy images with Retrobatch with messaging via Apple Events. 
- Copy images into already existing photo libraries for Photos or Capture One Pro with messaging via Apple Events.
- Install a plugin for Lightroom Classic, then copy images into already existing photo libraries and target folders with messaging via a socket.

Alright, so far so good. Simple enough. Let's upgrade to Mojave, turn on sandboxing with some sensible checkboxes for accessing the photo library, some files, and the computer's camera, and highlight things that stop working.

#### Getting Connected

Either:

- Scan a camera's QR code using the Mac's webcam, then switch the Mac's WiFi network over
- If the user has "Launch when joining these networks" enabled, have a background helper launch Cascable Transfer when the user manually joins the camera's network.

#### Copying Images

Either:

- Copy images to a folder **chosen by the user**.
- Copy images with Retrobatch with **messaging via Apple Events**. 
- Copy images into **already existing photo libraries** for Photos or Capture One Pro **with messaging via Apple Events**.
- **Install a plugin** for Lightroom Classic, then copy images into **already existing photo libraries and target folders** with messaging via a socket.

Oof. Actually, I was completely expecting for the entire "Getting Connected" flow to stop working. But, for now, apps can see the connected WiFi network's name, get notifications when it changes, and have the computer switch to a new network.

### Overcoming The Sandbox Challenges

We have a few things tha broke:

- Getting access to folders chosen by the user
- Installing a plug-in for Adobe Lightroom Classic
- Accessing pre-existing photo library locations for various apps that we've been told about by the programs themselves.
- Messaging via Apple Events

Let's go through them:

### Managing User-Chosen Locations

User-chosen locations are handled for you by `NSOpenPanel` and other user-initiated operations like drag & drop, so often you don't need to care. However, this becomes more work if you want to remember user-chosen locations between application launches — your access is revoked when you stop using the resource and not automatically re-granted to you later if you're just saving paths.

In order to manage this, you must use URL bookmarks with the `.withSecutityScope` option, which are `Data` objects. URL bookmarks used in this way are created with: 

~~~~~~~~ swift
let bookmark = try url.bookmarkData(options: [.withSecurityScope], includingResourceValuesForKeys: nil, relativeTo: nil)
~~~~~~~~

…and returned to URLs with: 

~~~~~~~~ swift
var isStale: Bool = false
let resolvedURL = try? URL(resolvingBookmarkData: bookmarkData, options: [.withoutUI, .withoutMounting, .withSecurityScope], relativeTo: nil, bookmarkDataIsStale: &isStale)
~~~~~~~~

Additionally, when **not** using `NSOpenPanel` and friends, you must request access to the resource with: 

~~~~~~~~ swift
let granted = normalizedUrl.startAccessingSecurityScopedResource()
~~~~~~~~

…then stop it with:

~~~~~~~~ swift
url.stopAccessingSecurityScopedResource()
~~~~~~~~

These calls must be balanced, and you _only_ use them when restoring URLs via bookmarks - URLs given to you via `NSOpenPanel` and friends don't need this. But they do need to be saved as bookmarks so we can access them next time.

Managing all this can get a bit complex. Ideally, we want to treat all of our URLs the same, so we don't need to have things like `if destinationWasBookmarked { … }` type-code all over the place.

To manage all this for me, I made a wrapper class called `SecurityScopedURL`. The only time you need to care about where a URL is coming from is when you initialise the object:

~~~~~~~~ swift
let fromOpenPanel = SecurityScopedURL(wrapping: urlFromOpenPanel)
let fromBookmark = SecurityScopedURL(bookmarkData: dataFromUserDefaults)
~~~~~~~~

From this point on, all `SecurityScopedURL` objects are treated the same. You keep them around in your application, and once you're done with them and they're deallocated, they will automatically call `stopAccessingSecurityScopedResource()` as needed. The class correctly handles multiple uses of the same location, so if you have multiple URL objects for the same on-disk location, your access won't be revoked until the last one is deallocated.

This class basically abstracts away the implementation details of getting and releasing access to user-chosen locations, and can be a huge time-saver. The class is available on GitHub here. (link)

### Installing a plug-in for Adobe Lightroom Classic

This is particularly specific to this app, but the overall problem isn't — we have a fixed path we want to work inside, in a location that's not easily accessible to the user. In our case, we want to install a plug-in to Adobe Lightroom that allows us to communicate with it to import photos — and Lightroom plug-ins go in `~/Library/Application Support/Adobe/Lightroom`. 

It would be an absolutely awful experience for the user to ask them to provide us access to the location via the above mechanisms — explaning what we're doing and why they need to rummage around inside a hidden-by-default folder. 

<img src="/pictures/mac-the-new-way/LightroomConfigPluginInstallPrompt.png" width="800" /> \\
*Of course, never install anything into the user's system without asking.*
{:.center .no-border}

Thankfully, this case is provided for by the available entitlements!

~~~~~~~~ xml
 <key>com.apple.security.temporary-exception.files.home-relative-path.read-write</key>
 <array>
     <string>/Library/Application Support/Adobe/Lightroom/</string>
 </array>
~~~~~~~~

A couple of things to note here:

- This is an entitlement for a `home-relative-path`, but you don't include the `~` character in the path.
- If you're referencing a folder, you must include the trailing `/`, otherwise you only get access to a file at that path, rather than a folder and its contents.
- Only use `read-write` if you actually need to write to that location — otherwise use the `read-only` variant. App Review will ding you if you don't.
- There are also `absolute-path` variants of these entitlements.

Locations granted to your app via this method aren't considered "user-granted", and therefore don't need to be wrapped around security-scoped bookmarks or `SecurityScopedURL` — you can just access these locations as you previously would have.

### Accessing pre-existing photo library locations for various apps that we've been told about by the programs themselves

Sometimes, we need to deal with paths that aren't known at compile-time, but aren't explicitly given to us by the user. In our case, when we talk to Adobe Lightroom or Capture One Pro, the apps give us the location of the user's photo library — and we'd like to put photos in there too!

Unfortunately, entitlements can't help us here. These may as well be completely arbitrary paths, and the sandbox has no mechanism for apps to "hand off" access to a location to other apps integrating with it.

Therefore, we need to ask for access permission from the user if we don't already have access to a location for some other reason. We do this by trying to create a `SecurityScopedURL` from the given location:

~~~~~~~~ swift
if let scopedDestination = SecurityScopedURL(requestingAccessTo: urlFromLightroom) {
    // Hooray! We already have access!
}
~~~~~~~~

If we get `nil` back, we don't have access and we have to ask the user for help. We present this UI (in the centre, with the warning triangle and the **Grant…** button):

<img src="/pictures/mac-the-new-way/LightroomConfigWithGrantUI.png" width="800" />
{:.center .no-border}

Clicking the **Grant…** button opens up an `NSOpenPanel` set to the path we want access to, with an explanation of what's going on:

<img src="/pictures/mac-the-new-way/LightroomConfigGrantPanel.png" width="800" />
{:.center .no-border}

Of course, we need to handle the fact that the user can navigate away and choose another location: 

<img src="/pictures/mac-the-new-way/LightroomConfigGrantFailed.png" width="457" />
{:.center .no-border}

All being well, we create a `SecurityScopedURL` for the chosen location and store the bookmark away for future use so we don't have to ask the user every time. 

This is by far the most discordant user experience we encountered when moving into the sandbox. Entitlements have allowed to to provide our users with decent (or at least understandable) experiences for almost everything, but not this. 

### Messaging via Apple Events

This one isn't strictly a sandboxing issue. macOS 10.14 Mojave added much tighter control over Apple Events to _all_ applications, and the sandbox adds the additional restriction of having to pre-declare with application(s) you're going to be communicating with. The sandbox part is easy enough, with the following additions to the entitlements:

~~~~~~~~ xml
<key>com.apple.security.automation.apple-events</key>
<true/>
<key>com.apple.security.temporary-exception.apple-events</key>
<array>
    <string>com.apple.Photos</string>
    <string>com.flyingmeat.Retrobatch</string>
    <string>com.phaseone.captureone12</string>
</array>
~~~~~~~~

I'm not sure how the ability to send Apple Events is not temporary but the list of which applications you can send them to _is_, but we'll think about that impending disaster another day.

New in Mojave is this:

<img src="/pictures/mac-the-new-way/AppleEventPermissionDialog.png" width="532" />
{:.center .no-border}

That smaller text at the bottom there is provided by your application's `Info.plist` file. If you build with the macOS 10.14 SDK or higher, you're required to have this string present — you only get one for all target applications:

~~~~~~~~ xml
<key>NSAppleEventsUsageDescription</key>
<string>Cascable Transfer needs to control this application in order to export photos to it.</string>
~~~~~~~~

In order to provide a nice(er) experience around this, Mojave has a new API: `AEDeterminePermissionToAutomateTarget()`. Using this, we can discover our authorisation state for automating another application. However, the header file this function lives in has the following note: 

> The target AEAddressDesc must refer to an already running application.

This means that we can't determine if we can automate an application unless it's running.

So, in order to start automating something, we need to:

- Determine whether it's running or not.
- Launch the target if it's not running and it's appropriate to do so.
- Determine if we have permission to automate.
- If we don't, ask for permission.
- Once an application is running and we have permission, we create a scripting bridge object for it and away we go.

<img src="/pictures/mac-the-new-way/LaunchAppExample.png" width="800" /> \\
*It's really poor form to launch apps in a way that might be surprising to the user. In Cascable Transfer, we have the user click a button to continue if our target isn't running.*
{:.center .no-border}

In all this mess is the fact that the user can launch and quit the target as they please, and can add or remove permission for us to automate the target at any time. Actually asking for permission is only a small part of the problem!

To wrap all this up, I made a class called `ScriptingBridgeSession`. Here's an example of it in use:

~~~~~~~~ swift
let id = "com.phaseone.captureone12"
let bridge = ScriptingBridgeSession<CaptureOne12Application>(bundleId: id)
let observer = bridge.addStateObserver({ bridge, state in
    self.stateUpdated(state)
})

func stateUpdated(_ state: ScriptingBridgeSession<CaptureOne12Application>.State) {
    switch state {
    case .notRunning: 
        // The application isn't running.
        displayLaunchCaptureOneButton()

    case .runningWithPendingScriptingAccess:
        // The application is running, but the user hasn't been asked for
        // permission to allow us to automate it. This state can occur
        // when the user already has the application open, independently
        // of anything to do with us.
        displayAskForPermissionButton()

    case .runningWithDeniedScriptingAccess:
        // The application is running, but the user has denied automation.
        displayError("In order to import to Capture One, you must allow
                      Cascable Transfer permission to automate it.")

     case .runningWithScriptingAccess(let captureOneApplication):
        // The application is running, and we've been approved permission
        // to automate it. In this case, the ScriptingBridgeSession class
        // automatically creates a ScriptingBridge object for us!
        captureOneApplication.setProgressText("Importing from Cascable Transfer…")
        captureOneApplication.currentDocument?.importImages(at: copiedImageURLs)
    }
}

func launchAndAskForPermissionToAutomate() {
    // This method call will launch the target application (if needed) and
    // request permission to automate it (if needed).

    captureOneBridge.attemptToGainScriptingAccess(completionHandler: { state in
        // We get a new state here, but our observer will also be called.
        print("Launch and gain scripting access completed with state: \(state)")
    })
}
~~~~~~~~

The class handles watching the workspace for the application being launched and quit by the user, provides methods for launching the application yourself and asking for pemission at a time that best matches your app's workflow, then will automatically generate a Scripting Bridge object for the target application once it's appropriate to do so.

To use this class, you will need to generate your own Scripting Bridge application objects. You can find examples on how to do this and some helper code in the GitHub repo for all this here. (link)


### Bonus: Full Disk Access

We didn't end up needing Full Disk Access for this app, but for a while I thought we did and I put the work into implementing a nice user flow for it.

The first problem with Full Disk Access is that there's no API for it — you just can't access some files. The problem is, there are lots of reasons you might not be able to access files that have nothing to do with Full Disk Access, and if you're running on macOS versions lower than 10.14 Mojave, you _definitely_ can't ask for Full Disk Access!

The second problem is the user flow. Granting an app Full Disk Access is (I presume intentionally) an absolutely awful time even if you know what you're doing — the list is in a sub-section of a tab in a system preferences pane. Blegh.

To solve the first problem, I wrote `FullDiskAccessController`. This is a small class that watches a file on disk to see if you have access to it.

~~~~~~~~ swift
let access = FullDiskAccessController(watchingAccessTo: someFileUrl)
access.observe(\.state) { access, _ in
    switch access.accessState {
    case .notPresent:
        // The file isn't present on disk.

    case .denied:
        // We currently don't have access to the file.

    case .allowed: 
        // We currently do have access to the file.
    }
}
~~~~~~~~

As discussed earlier, since there's no API for Full Disk Access, it's impossible to tell if not having access to a file is due to Full Disk Access. The closest we can figure out is to point the `FullDiskAccessController` to a file we really should be able to access (something in the user's home folder).

In order to help your application decide how to present file access errors to its users, there are some convenience methods — `systemHasFullDiskAccessSetting` and `errorCouldBeResolvedWithFullDiskAccess(_:)` being the most useful.

~~~~~~~~ swift
if FullDiskAccessController.systemHasFullDiskAccessSetting {
    // This will return `true` on macOS 10.14 or later.
    displayFullDiskAccessUI()
}

do {
    let data = try Data(contentsOf: fileUrl)
} catch {
    if FullDiskAccessController.errorCouldBeResolvedWithFullDiskAccess(error) {
        // If this returns true, the error may have been caused by lack of 
        // Full Disk Access AND the system supports the feature. Asking the
        // user to provide it may help.
        displayFullDiskAccessUI()
    } else {
        // The error is not one that could be caused by lack of Full Disk Access,
        // or the system doesn't have the Full Disk Access Feature. We shouldn't 
        // ask the user to provide it.
        displayError(error)
    }
}
~~~~~~~~

As for the user, I had a look around and really liked how [DaisyDisk](https://daisydiskapp.com) approached the problem. 

--- 

### Part 1 Conclusion and Useful Resources

Phew! While all that that seems to be a lot of extra work just to carry on doing what we've already been doing, I personally don't think it's that bad. These extra helper classes abstract a lot of the work away — so the app just uses `SecurityScopedURL` objects instead of `URL`s, for instance. In the Apple Event example, we already had to track whether or not the application was running and make a `ScriptingBridge` object for the application, so making sure we have permission to automate the target app is just another step in that chain.

Most of the classes I talk about here can be found in my ModernMacHelpers repo, which can be found here on GitHub.

Additionally, you may find Apple's list of [Sandbox Entitlements](https://developer.apple.com/documentation/security/app_sandbox_entitlements) useful, as well of the list of [Temporary Exception Entitlements](https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/AppSandboxTemporaryExceptionEntitlements.html) which are used fairly extensively here. 

If you're shipping directly — you're done! However, if you're submitting to the Mac App Store, it's time to continue on…

## Part 2: Overcoming Policy — Submitting to the Mac App Store
