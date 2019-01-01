---
title: "iOS Touch Session Redirection with Method Swizzling and More!"
created_at: 2019-01-01 11:50:12 +0100
kind: article
published: false
---

### The Basic Anatomy of a Touch Session



### Limits of the One View Per Session Model

Usually, UIKit's touch model is perfectly fine. Having a single view handle an entire touch session is much easier to program for in the vast majority of cases, especially since we can redirect a touch session to the desired starting point fairly easily with `hitTest:` and friends.

However, consider the following UI. 

[Make animation with tapping on button and sliding it, then holding and sliding in one motion]

+-----------------------------+
| ------O---------------------|
+-------------  --------------+
              \/
          [ Button ]

We want to be able to have the user interact with the button and slider in two ways:

- Tap the button, then swipe left and right on the slider to adjust it.

- Tap and hold the button, then swipe left and right to adjust the slider without releasing their finger.

The first one of these is absolutely no problem — it's the standard way of working with UIKit. The second, however, is a little more challenging. After some digging around in the documentation, most people would likely conclude that the only sensible way of doing this is with a chain of gesture recognisers and code to calculate the new slider value, or with a custom UIKit component that implements its own button, slider, and completely custom touch handling (via either "traditional" tracking or with gesture recognisers) to implement the desired behaviour.

But… we have perfectly good UIButton and UISlider components already, and creating a *good* custom implementation is a lot of work. The built-in controls give accessibility, support for dynamic type, and so much more. If we could just hand off the touch session from the button to the slider once its displayed, we'd be able to implement this with no extra code - the slider's action methods would be called as normal, and there'd be no distinction between the two UI flows in the model/controller code.

And so begins the rabbit hole.

### Touch Session Handoff

In theory, this problem isn't too complicated. A shared superview that overrides `hitTest:` to always return itself will mean it always gets to handle touches, then it can watch as touches move around its bounds and simulate "sub-sessions" to its subviews.


               [ custom touch view ]                         [ button ]       [ slider ]

---- [touchesBegan:] ----> | ---------- [touchesBegan:] ------>  |
---- [touchesMoved:] ----> | ---------- [touchesMoved:] ------>  |
---- [touchesMoved:] ----> | ---------- [touchesMoved:] ------>  |
---- [touchesMoved:] ----> | ---------- [touchesMoved:] ------>  |
---- [touchesMoved:] ----> | ---------- [touchesEnded:] ------>  |
                           | ------------------- [touchesBegan:] --------------> |
---- [touchesMoved:] ----> | ------------------- [touchesMoved:] --------------> |
---- [touchesMoved:] ----> | ------------------- [touchesMoved:] --------------> |
---- [touchesMoved:] ----> | ------------------- [touchesMoved:] --------------> |
---- [touchesEnded:] ----> | ------------------- [touchesEnded:] --------------> |

Unfortunately, this approach on its own doesn't work. UITouch objects have a couple of properties that most UIKit controls filter on:

- `phase`: Touches in the "moved" phase often get filtered out in the `touchesBegan:` method.
- `view`: UIKit controls often filter using `UIEvent`'s `touchesForView:` method, which will remove our forwarded touches.

Unfortunately, the `phase` and `view` properties of `UITouch` are read-only, and making new instances of `UITouch` by subclassing at this point in the touch session effectively means synthesising an entire event system, which is a little too heavy for our use here. 

Do you want to:

1. Take the sensible approach and admit defeat? 
2. Keep digging deeper!

### 1. I want to take the sensible approach and admit defeat.

To be honest, you're probably the smarter of the two of us. Futzing around with touch handling (i.e., most users' only way of interacting with your app) is definitely in the "advanced" category. Go build a custom component and be proud.

### 2. I want to keep digging deeper!

You and me? We can be friends. I like you. Onwards!

### Leaving the Swift Sandbox

To accomplish what we want to achieve we'll still be writing Swift code, but we'll be firmly dropping down into some advanced areas of the Objective-C feature set. If this makes you roll your eyes and start to lose interest, please allow me to get on my soapbox for a second before you leave:









