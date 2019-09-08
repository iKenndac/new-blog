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
- Messaging via Apple Events
- Accessing pre-existing photo library locations for various apps that we've been told about by the programs themselves.
- Installing a plug-in for Adobe Lightroom Classic

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




### Useful Resources

- Link to list of sanbox entitlements 
- Link to documentation on permissions prompts and strings. 

