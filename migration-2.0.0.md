## SwiftVideoBackground 2.0.0 Migration Guide

Notable changes in 2.0.0:
- renamed class from `BackgroundVideo` to `VideoBackground` for consistency with package name
- class is no longer a subclass of `UIView`
- only one API is exposed, `play()`, see [documentation](http://wilsonding.com/SwiftVideoBackground/) for more information
- `play()` requires a `UIView` passed in. It will play your video on this view. Typical usage would just be to pass in the `UIView` class property of your `UIViewController`.

Example:

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

In this example, the class property `view` of the `UIViewController` was passed in. No need to create a new `UIView`.

> Be sure to check the [docs](http://wilsonding.com/SwiftVideoBackground/) for info about playing multiple videos, sound, video brightness, and looping options.
