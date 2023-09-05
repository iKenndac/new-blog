---
kind: article
author: "Daniel Kennett"
layout: post
title: "Server-Side Swift For Small Startup Success: Additional Reading"
created_at: 2023-09-05 14:00:00 +0100
categories:
- General
- Programming
---

This year at [iOSDevUK](https://www.iosdevuk.com), I gave a talk on using Swift on the Server with Vapor to build an app's backend in Swift. 

You can download the slides [here](/pictures/ServerSideSwiftServicesForSmallStartupSuccess.pdf).

This post contains some links to additional resources.

### The Basics

- [Vapor](https://vapor.codes) is the Swift framework used in the projects mentioned.

- [Photo Scout](https://photo-scout.app) is the app used in most of the examples.

### Technical

- When deploying a Swift/Vapor app to Heroku, you'll need to use the [Vapor Heroku Buildpack](https://github.com/vapor-community/heroku-buildpack).

- Vapor is built upon [SwiftNIO](https://github.com/apple/swift-nio).

- We're all very much looking forward to the unified Foundation project coming to fruition. More details [here](https://www.swift.org/blog/future-of-foundation/), with the GitHub repo [here](https://github.com/apple/swift-foundation).

- For sending metrics to [Datadog]() from your project, you'll need the [dogstatsd SPM package](https://github.com/DataDog/swift-dogstatsd), and for Heroku the [Datadog Heroku buildpack](https://docs.datadoghq.com/agent/basic_agent_usage/heroku/) to get the required local agent.

