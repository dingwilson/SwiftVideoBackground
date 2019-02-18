# Change Log

## [3.2.0](https://github.com/dingwilson/SwiftVideoBackground/tree/3.2.0)

#### Features:
- make `videoGravity` configurable.
- add caching for remote URLs (by danibachar).
- add thumbnail image (by danibachar).

## [3.1.0](https://github.com/dingwilson/SwiftVideoBackground/tree/3.1.0)
(2018-10)
- Updated to Swift 4.2

## [3.0.0](https://github.com/dingwilson/SwiftVideoBackground/tree/3.0.0)
(2018-02-26)
#### BREAKING CHANGES:
- Removed support for passing in multiple videos to play one after another
- Renamed `alpha` to `darkness`
- Removed non-throwing `play()`. Use the throwing `play()` instead.

#### Features:
- Added a singleton called `shared`. Now users don't need to retain an instance of `VideoBackground` to play a video.
  - Users can still create new instances if needed, i.e. if needed to play multiple videos simultaneously.
- Add support for playing video from a local or remote URL
- Add APIs for pause, restart, resume, darkness, isMuted, & willLoopVideo
- Make `playerLayer` public to allow advanced control and customization
- Add `setAudioSessionAmbient` to `play`. Set to `true` by default.

#### Fixes:
- Add clean up code to `play()`, so multiple calls to it should work smoothly

## [2.1.0](https://github.com/dingwilson/SwiftVideoBackground/tree/2.1.0)
(2018-02-19)
- Added a singleton called `shared`. Now users don't need to retain an instance of `VideoBackground` to play a video.
  - Users can still create new instances if needed, i.e. if they needed to play multiple videos simultaneously.
- Added throwing APIs that throw a `videoNotFound` error that returns the video name and type in question.
- Added deprecation warning for old API.
- Added new public struct `VideoInfo` that contains a video's name and type.
- Added new API that takes in an array of `VideoInfo`, and plays them in sequence.
- Added some clean up code that gets called on each play(), in an attempt to reset state in the event of multiple calls to `play()`.

## [2.0.4](https://github.com/dingwilson/SwiftVideoBackground/tree/2.0.4)
(2018-02-16)
- Fixed layout issues for alpha overlay when device orientation changed

## [2.0.3](https://github.com/dingwilson/SwiftVideoBackground/tree/2.0.3)
(2018-02-14)
- Fixed layout issues when device orientation changed
- Fixed issues with images in README not showing up in Cocoapods/Jazzy docs

## [2.0.2](https://github.com/dingwilson/SwiftVideoBackground/tree/2.0.2)
(2018-02-14)
- Added observer to handle application state transition back to foreground

## [2.0.1](https://github.com/dingwilson/SwiftVideoBackground/tree/2.0.1)
(2018-01-30)
- Added a basic test and travis-ci integration
- Fixed podspec documentation generation

## [2.0.0](https://github.com/dingwilson/SwiftVideoBackground/tree/2.0.0) (2017-12-14)
**Major Release: BREAKING CHANGES**
- renamed class from `BackgroundVideo` to `VideoBackground` for consistency with package name
- class is no longer a subclass of `UIView`
  - instantiate an instance simply with `let videoBackground = VideoBackground()`
- only one API is exposed, `play()`. `play()` requires a `UIView` passed in. It will play your video on this view. Typical usage would just be to pass in the `UIView` class property of your `UIViewController`.

For more information, please see the [documentation](http://wilsonding.com/SwiftVideoBackground/)

For an example and help with migrating from previous versions, please see the [migration guide](migration-2.0.0.md)

## [1.0.1](https://github.com/dingwilson/SwiftVideoBackground/tree/1.0.1) (2017-10-31)
- Modified minimum deployment target to iOS 8.0

## [1.0.0](https://github.com/dingwilson/SwiftVideoBackground/tree/1.0.0) (2017-10-26)
Official 1.0.0 major release of SwiftVideoBackground.
