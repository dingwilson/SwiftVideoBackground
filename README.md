<p align="center">
  <img src="https://github.com/dingwilson/SwiftVideoBackground/raw/master/Assets/banner.png" width="780" title="SwiftVideoBackground">
</p>

[![Build Status](https://travis-ci.org/dingwilson/SwiftVideoBackground.svg?branch=master)](https://travis-ci.org/dingwilson/SwiftVideoBackground)
[![CocoaPods Version Status](https://img.shields.io/cocoapods/v/SwiftVideoBackground.svg)][podLink]
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/dt/SwiftVideoBackground.svg)](https://cocoapods.org/pods/SwiftVideoBackground)
[![CocoaPods](https://img.shields.io/cocoapods/dm/SwiftVideoBackground.svg)](https://cocoapods.org/pods/SwiftVideoBackground)
![Platform](https://img.shields.io/badge/platforms-iOS-333333.svg)
[![Swift](https://img.shields.io/badge/Swift-3.0+-orange.svg)](https://swift.org)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)][mitLink]

<p align="center">
  <img src="https://github.com/dingwilson/SwiftVideoBackground/raw/master/Assets/Spotify.gif" width="369" title="Screenshot">
</p>

SwiftVideoBackground is an easy to use Swift framework that provides the ability to play a video on any UIView. This provides a beautiful UI for login screens, or splash pages, as implemented by Spotify and many others.

## Features

- Play a video with one line of code
- Play an array of videos sequentially
- Automatically adjusts when device orientation changes
- Automatically resumes video when app re-enters foreground
- Loop videos *(optional)*
- Mute sound *(optional)*
- Darken videos so overlying UI stands out more *(optional)*
- [Documentation](http://wilsonding.com/SwiftVideoBackground/)

## Contents

1. [Requirements](#requirements)
2. [Integration](#integration)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
    - [Manually](#manually)
3. [Migration Guide](#migration-guide)
4. [Usage](#usage)
5. [License](#license)
6. [Authors](#authors)

## Requirements

- Swift 3+
- iOS 8+

## Integration

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `SwiftVideoBackground` by adding it to your `Podfile`:

For Swift 4:
```ruby
	pod 'SwiftVideoBackground', '~> 2.1'
```

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

1. for Projects, just drag VideoBackground.swift to the project tree
2. for Workspaces, include the whole SwiftVideoBackground.xcodeproj

## Migration Guide

Version 2.0.0 brings improvements and breaking changes. See the quick migration guide [here](migration-2.0.0.md).

## Usage

#### Example

``` swift
import UIKit
import SwiftVideoBackground

class MyViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    try? VideoBackground.shared.play(view: view, name: "myvideo", type: "mp4")
  }
}
```

> Documentation for Version 0.06 (Swift 3) can be found [here](README-0.06.md).

#### Play Multiple Videos

```swift
let pokemon = VideoInfo(name: "pokemonIntro", type: "mp4")
let digimon = VideoInfo(name: "digimonIntro", type: "mp4")

try? VideoBackground.shared.play(view: view, videoInfos: [pokemon, digimon])
```

#### Customization

`play()` has three additional optional parameters for customization:
- `isMuted`: Bool - Indicates whether video is muted. Defaults to `true`.
- `alpha`: CGFloat - Value between 0 and 1. The higher the value, the darker the video. Defaults to `0`.
- `willLoopVideo`: Bool - Indicates whether video should restart when finished. Defaults to `true`.

So for example:

``` swift
VideoBackground.shared.play(
    view: view,
    name: "myvideo",
    type: "mp4",
    isMuted: false,
    alpha: 0.25,
    willLoopVideo: true
)
```

-> will play the video with the sound on, slightly darkened, and will continuously loop.

> Any combination of the three can be included or left out.

#### Singleton

`SwiftVideoBackground` includes a singleton instance that can be conveniently accessed with `VideoBackground.shared`. An instance of `VideoBackground` can only play one video on one `UIView` at a time. So if you need to play on multiple `UIView`s, you can instantiate more instances of `VideoBackground`:

```swift
let myVideoBackground = VideoBackground()
```

#### Adding Videos To Your Project

You must properly add videos to your project in order to play them. To do this:
1. Open your project navigator
2. Select your target
3. Select `Build Phases`
4. Select `Copy Bundle Resources`
5. Click `+` to add a video

![add video to project](https://github.com/dingwilson/SwiftVideoBackground/raw/master/Assets/add-video-to-project.png "add video to project")

#### Preventing Video From Muting Other Audio On Device

By default, audio played on your app will mute all other audio playing on the device. To prevent this, configure the `AVAudioSession` by adding the following code to your app's `application(_:didFinishLaunchingWithOptions)` function in the `AppDelegate` class:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    if #available(iOS 10.0, *) {
        try? AVAudioSession.sharedInstance().setCategory(
           AVAudioSessionCategoryAmbient,
           mode: AVAudioSessionModeDefault
        )
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    return true
}
```

For more information, see the AVPlayer [docs](https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/AudioSessionBasics/AudioSessionBasics.html#//apple_ref/doc/uid/TP40007875-CH3-SW1).

## License

`SwiftVideoBackground` is released under an [MIT License][mitLink]. See [LICENSE](LICENSE) for details.

## Authors

[Wilson Ding](https://github.com/dingwilson), [Quan Vo](https://github.com/quanvo87)

**Copyright &copy; 2016-present Wilson Ding.**

*Please provide attribution, it is greatly appreciated.*

[podLink]:https://cocoapods.org/pods/SwiftVideoBackground
[mitLink]:http://opensource.org/licenses/MIT
