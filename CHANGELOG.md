# Change Log

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

For an example and help with migrating from previous verisons, please see the [migration guide](migration-2.0.0.md)

## [1.0.1](https://github.com/dingwilson/SwiftVideoBackground/tree/1.0.1) (2017-10-31)
- Modified minimum deployment target to iOS 8.0

## [1.0.0](https://github.com/dingwilson/SwiftVideoBackground/tree/1.0.0) (2017-10-26)
Official 1.0.0 major release of SwiftVideoBackground.
