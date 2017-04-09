# ValueTransformerKit

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat
            )](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-macos-lightgrey.svg?style=flat
             )](https://developer.apple.com/resources/)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat
             )](https://developer.apple.com/swift)
[![Issues](https://img.shields.io/github/issues/phimage/AlertController.svg?style=flat
           )](https://github.com/phimage/AlertController/issues)
[![Cocoapod](http://img.shields.io/cocoapods/v/NSAlertController.svg?style=flat)](http://cocoadocs.org/docsets/NSAlertController/)

A `NSViewController` to display an alert message to the user.
This class replaces the `NSAlert` class and is inspired from `UIAlertController`.

After configuring the alert controller with the actions and style you want, present it using `presentViewControllerAsSheet`.

```swift
let controller = AlertController(title: "Alert title", message: "An alert message", preferredStyle: .warning)
parentVC.presentViewControllerAsSheet(controller)

```
<img align="center" src="Demo/DemoInfo.png">
## Usage

### Add a simple dismiss action
```swift
controller.add(action: AlertAction.dismiss(for: controller, title: "Ok"))
```
### Add custom action
```swift
controller.add(action: AlertAction(title: "Report...") { action in
    NSWorkspace.shared().open(URL(string: "https://github.com/phimage/AlertController/issues")!)
})
```
### Choose a style
```swift
controller.addAction(title: "", style: .helpButton) { action in
    // show error help
}
```

### Customize buttons bar
```swift
controller.buttonsBar.color = NSColor.red
controller.buttonsBar.buttonSpace = 8
```
<img align="center" src="Demo/DemoAlert.png">

## Todo
- More customization
  - align buttons left or right
  - automatic helpButton on left
- Maybe input text fields

## Installation

### Using CocoaPods ##
[CocoaPods](https://cocoapods.org/) is a centralized dependency manager for
Objective-C and Swift. Go [here](https://guides.cocoapods.org/using/index.html)
to learn more.

1. Add the project to your [Podfile](https://guides.cocoapods.org/using/the-podfile.html).

    ```ruby
    use_frameworks!

    pod 'AlertController'
    ```

2. Run `pod install` and open the `.xcworkspace` file to launch Xcode.

### Using Carthage ##
```ruby
github 'phimage/AlertController'
```
