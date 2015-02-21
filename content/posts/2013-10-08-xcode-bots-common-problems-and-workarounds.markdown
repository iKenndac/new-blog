---
kind: article
author: Daniel Kennett
layout: post
title: "Xcode Bots: Common Problems And Workarounds"
created_at: 2013-10-08 22:38
comments: true
categories:
- Programming
---

I *love* Continuous Integration. I've never bothered with it for my side projects since it didn't seem worth the effort, but now it's built into Xcode I thought "This is Apple! Two clicks and I'm done, right?"

Wrong.

I spent a few hours battling with the Xcode service on my Mac OS X Server, and below I detail workarounds for the problems I encountered getting my projects to build.

Don't get me wrong — I love Bots, and I'm sure that in a few months these issues will be fixed as they're getting tripped up by very common situations. Remember to file those Radars!

<img src="/pictures/bots/bots.png" /> \\
 *After a little work, my main side projects are continuously integrated. Hopefully this post will help you do it faster than I did!* 
{:.center}

**Note:** All these tips assume you're using git. If not, well, you're on your own!

## Repositories that require an SSH key to access

If you host your repository on GitHub or similar, you're likely to use an SSH key to access your code — especially if you have a private repository. GitHub will actually let you check out over https, but where's the fun in that when you can follow this simple seven-step process?

1) If your SSH key requires a password, you need to make a password-less version of it using `ssh-keygen -p` (when it asks for a new password, just hit return).

2) In Xcode, choose *Product → Create Bot…*, name your Bot and untick *Integrate Immediately* and click *Next*.

3) In the next pane, choose *Guest* as your authentication method. This will succeed on your local machine since you have your keys installed. Continue through and create your Bot. 

<img src="/pictures/bots/guest.png" />
{:.center}

4) Open the *Server* application and find your new repository and edit it. Change the authentication method to *SSH Key* and the user name to the correct value (this is `git` for GitHub). 

5) At this point, you'll notice a new SSH key has been created for you. Either upload the public key to your host, or click *Edit…* to replace it with your own password-less keys.

<img src="/pictures/bots/server-ssh.png" />
{:.center}
 
 6) Save your changes, return to Xcode and click "Integrate Now" in your new Bot.
 
 7) Success! 
 
<img src="/pictures/bots/success.png" />
{:.center}
 
 8) File a Radar asking Apple to add the *SSH Key* authentication option to Xcode itself. Feel free to duplicate mine: [#15184645: Bots: Can't enter an SSH Key to authenticate a repository in Xcode](http://www.openradar.me/15184645).
 
 It's worth noting that you can make this process slightly simpler by manually adding the repository to the Xcode service in the *Server* app before creating your Bot. This way, you can set up your SSH keys right away. Make sure, however, that you get the URL of the repository to match the URL you have checked out on your local machine, otherwise Xcode won't pick it up.
 
## Code Signing and Provisioning Profiles

Ahh, Code Signing. It *just* got easy, and now there's a new spanner in the works.

Bots run their builds in their own user. This means that even if they build fine when you log into your server, they may fail to build in the Bot. The tricky part here is making your private keys available to the Bot — downloading the certificate from Apple's Developer Center doesn't give you back the private key, so you'll need to import it from a machine with a working build setup using Xcode's Developer Profile Export/Import.

Once you can log into your server and build your project with signing, a simple way to allow Bots to access your signing certificates is to copy them from your user's Keychain to the system Keychain. 

<img src="/pictures/bots/keychain.png " /> \\
 *Make sure you copy the private key by dragging it to the System Keychain. The certificate will be copied as well.* 
{:.center .no-border}

Once you have your certificates in the System Keychain, your Bots will be able to access them.

Adding your Developer Team to the Xcode service in the *Server* app should automatically deal with Provisioning Profiles. If not, put your profiles in `/Library/Server/Xcode/Data/ProvisioningProfiles`. 

## Submodules

Submodules work fine **as long as you don't have a detached HEAD**. If they require SSH keys to access them, after creating your Bot you'll need to go over to the *Server* app and manually set up the keys for each submodule.

If you're not sure if you have a detached HEAD, you can check from the command line or Xcode. On the command line, run `git status` in each submodule. If you get something like `# HEAD detached at 89970d0`, you're in a detached HEAD. From Xcode, try to create a Bot. When it's time to define authentication for each repository, Xcode will tell you the state of each submodule.

<img src="/pictures/bots/detached-head.png" /> \\
 *If any of your submodules read "(detached from…)", they won't work.* 
{:.center}

To fix this, you need to get back on a branch. The quickest, hackiest way to do this is to run `git checkout -b my-awesome-branch` in the submodule to make a new branch. Once that new branch is pushed and available on your remote, your Bot will be able to check it out correctly.

**Note:** I've noticed that Xcode 5.0.1 doesn't seem to refresh branch information quickly. Try relaunching Xcode if things get weird. 

Don't forget to file a Radar! Again, feel free to duplicate mine: [#15184702: Bots: Checkout failure in git projects that have submodules with a detached HEAD](http://www.openradar.me/15184702).
 
## I made a mistake and now I can't fix the repository from Xcode!

If you accidentally added a Bot with incorrect authentication details or some other mistake, deleting the Bot may not fix it. You also need to delete the repositories from the Xcode service in the *Server* app. When you do that, Xcode will offer to reconfigure them when you create a new Bot.

## The Future

Despite these niggles, I really love Continuous Integration and Bots. I'll try to update this post as I find more issues, and hopefully as the Bots feature matures and these issues go away. [Follow me on Twitter](http://twitter.com/iKenndac) to get update announcements.

## Updates

* October 9th, 2013: Added Radar bug numbers for SSH keys and submodules.
