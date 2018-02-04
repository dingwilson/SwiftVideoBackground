<p align="center">
  <img src="Assets/banner.png" width="780" title="SwiftVideoBackground">
</p>

[![CocoaPods Version Status](https://img.shields.io/cocoapods/v/SwiftVideoBackground.svg)][podLink]
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/dt/SwiftVideoBackground.svg)](https://cocoapods.org/pods/SwiftVideoBackground)
[![CocoaPods](https://img.shields.io/cocoapods/dm/SwiftVideoBackground.svg)](https://cocoapods.org/pods/SwiftVideoBackground)
![Platform](https://img.shields.io/badge/platforms-iOS-333333.svg)
[![Swift](https://img.shields.io/badge/Swift-3.0+-orange.svg)](https://swift.org)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)][mitLink]

<p align="center">
  <img src="Assets/Spotify.gif" width="369" title="Screenshot">
</p>

SwiftVideoBackground is an easy to use Swift framework that provides the ability to add a UIView of a video playing in the background to any ViewController. This provides a beautiful UI for login screens, or splash pages, as implemented by Spotify and many others.

1. [Requirements](#requirements)
2. [Integration](#integration)
    - [Cocoapods](#cocoapods)
    - [Carthage](#carthage)
    - [Manually](#manually)
3. [Usage](#usage)
4. [License](#license)

## Requirements

- Swift 3+
- iOS 8+

## Integration

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `SwiftVideoBackground` by adding it to your `Podfile`:

For Swift 3:
```ruby
	pod 'SwiftVideoBackground', '0.06'
```

#### Carthage
You can use [Carthage](https://github.com/Carthage/Carthage) to install `SwiftVideoBackground` by adding it to your `Cartfile`:
```
github "dingwilson/SwiftVideoBackground"
```

#### Manually

To use this library in your project manually you may:  

1. for Projects, just drag BackgroundVideo.swift to the project tree
2. for Workspaces, include the whole SwiftVideoBackground.xcodeproj

## Usage

Import the framework into the ViewController
```swift
import SwiftVideoBackground
```

Link a UIView within a ViewController within the Storyboard to a BackgroundVideo item, or link it programmatically.
```swift
var backgroundVideo : BackgroundVideo!
```

Use the `createBackgroundVideo` function, with the name of the video or gif under `name`, and the file type under `type`. You can also include an alpha value between 0 and 1 under `alpha`, to adjust the brightness of the video.
```swift
backgroundVideo.createBackgroundVideo(name: "Background", type: "mp4")
```
```swift
backgroundVideo.createBackgroundVideo(name: "Background", type: "mp4", alpha: 0.5)
```

Note: Make sure you have added a video file to the project, and targeted the project. Also, make sure that you have set the module to `SwiftVideoBackground` for the BackgroundVideo UIView.

## License

`SwiftVideoBackground` is released under an [MIT License][mitLink]. See `LICENSE` for details.

**Copyright &copy; 2016-present Wilson Ding.**

*Please provide attribution, it is greatly appreciated.*

[podLink]:https://cocoapods.org/pods/SwiftVideoBackground
[mitLink]:http://opensource.org/licenses/MIT
