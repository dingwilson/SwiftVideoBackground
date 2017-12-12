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

SwiftVideoBackground is an easy to use Swift framework that provides the ability to play a video on any UIView. This provides a beautiful UI for login screens, or splash pages, as implemented by Spotify and many others.

1. [Requirements](#requirements)
2. [Integration](#integration)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
    - [Manually](#manually)
3. [Migration Guide](#migration-guide)
4. [Usage](#usage)
5. [License](#license)
6. [Contributors](#contributors)

## Requirements

- Swift 3+
- iOS 8+

## Integration

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `SwiftVideoBackground` by adding it to your `Podfile`:

For Swift 4:
```ruby
	pod 'SwiftVideoBackground', '~> 2.0'
```

For Swift 3:
```ruby
	pod 'SwiftVideoBackground', '~> 0.06'
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

## Migration Guide

Version 2.0 brings improvements and breaking changes. See the quick migration guide [here]().

## Usage

#### Example

``` swift
import UIKit
import VideoBackground

class MyViewController: UIViewController {
  private let videoBackground = VideoBackground()

  override func viewDidLoad() {
    super.viewDidLoad()

    videoBackground.play(view: view, videoName: "myvideo", videoType: "mp4")
  }
}
```

> Documentation for Version 0.06 (Swift 3) can be found [here]().

#### Customization Options

`play()` has three additional optional parameters:
- `isMuted`: Bool - Indicates whether video is muted. Defaults to `true`.
- `alpha`: CGFloat - Value between 0 and 1. The higher the value, the darker the video. Defaults to `0`.
- `willLoopVideo`: Bool - Indicates whether video should restart when finished. Defaults to `true`.

So for example:

``` swift
videoBackground.play(view: view,
                     videoName: "myvideo",
                     videoType: "mp4",
                     isMuted: false,
                     alpha: 0.25,
                     willLoopVideo: true)
```

-> will play the video with the sound on, slightly darkened, and will continuously loop.

#### Adding Videos To Your Project

You must properly add videos to your project in order to play them. To do this:
1. Open your project navigator
2. Select your target
3. Select `Build Phases`
4. Select `Copy Bundle Resources`
5. Click `+` to add a video

![add video to project](Assets/add-video-to-project.png "add video to project")

## License

`SwiftVideoBackground` is released under an [MIT License][mitLink]. See [LICENSE](LICENSE) for details.

## Contributors

- Author: [Wilson Ding](https://github.com/dingwilson)
- Collaborator: [Quan Vo](https://github.com/quanvo87)

**Copyright &copy; 2016-present Wilson Ding.**

*Please provide attribution, it is greatly appreciated.*

[podLink]:https://cocoapods.org/pods/SwiftVideoBackground
[mitLink]:http://opensource.org/licenses/MIT
