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

+-----------------------------+
| ------O---------------------|
+-------------  --------------+
              \/
          [ Button ]

We want to be able to have the user interact with the button and slider in two ways:

- Tap the button, then swipe left and right on the slider to adjust it.

- Tap and hold the button, then swipe left and right to adjust the slider without releasing their finger.



