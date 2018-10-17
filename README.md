# ActivityRings

[![Version](https://img.shields.io/github/release/HarshilShah/ActivityRings.svg)](https://github.com/HarshilShah/ActivityRings/releases/latest)
![Package Managers](https://img.shields.io/badge/supports-CocoaPods%20%7C%20Carthage-green.svg)
![Platforms](https://img.shields.io/cocoapods/p/ActivityRings.svg?style=flat)
[![License](https://img.shields.io/badge/license-MIT-yellow.svg)](https://github.com/HarshilShah/ActivityRings/blob/master/LICENSE)
[![Contact](https://img.shields.io/badge/contact-%40HarshilShah1910-3a8fc1.svg)](https://twitter.com/HarshilShah1910)

ActivityRings is an attempt to recreate the ring controls in Apple’s Activity app.

This project is a SpriteKit port of [Max Konovalov](https://github.com/maxkonovalov)’s pure UIKit implementation, [MKRingProgressView](https://github.com/maxkonovalov/MKRingProgressView).

![Demo](https://raw.githubusercontent.com/HarshilShah/ActivityRings/master/Resources/demo.gif)

## Requirements

- Swift 4.2
- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 4.0+

## Installation

ActivityRings is available via CocoaPods and Carthage.

### CocoaPods

To install ActivityRings using [CocoaPods](http://cocoapods.org), add the following line to your Podfile:
```
pod 'ActivityRings'
```
### Carthage

To install ActivityRings using [Carthage](https://github.com/Carthage/Carthage), add the following line to your Cartfile:

```
github "HarshilShah/ActivityRings"
```

## Usage

### Basics

To get started, import `ActivityRings`. To display the control, use the `ActivityRingView` class on iOS, macOS, and tvOS, and the `ActivityRingScene` class on watchOS.

### Customisation

The `ringWidth`, the `startColor`, the `endColor`, and the `backgroundRingColor` can all be customised.

### Progress

The progress of the ring can be set with or without animation.

To set the progress without animation, simply update the value of the `progress` variable.

To animate the progress, use the `animateProgress` method, which accepts two arguments:
- The desired final progress value
- The animation duration

## Notes

Some notes on performance:
- Since this control was written in SpriteKit, it relies heavily on the GPU, and so will not perform well or accurately in the simulator.
- The initial setup process is somewhat expensive, so animating the progress directly after presenting the view can cause some hiccups. This is being worked on, but in the meantime, delaying the animation by a second or so works around the issue.

## Apps Using *ActivityRings*

Feel free to submit a PR if you’re using this library in your apps.

## Author

Written by Harshil Shah. You can [find me on Twitter](https://twitter.com/HarshilShah1910).

The original UIKit implementation was written by [Max Konovalov](https://github.com/maxkonovalov).

## License

ActivityRings is available under the MIT license. See the LICENSE.md file for more info.
