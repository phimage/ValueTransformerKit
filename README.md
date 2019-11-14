# ValueTransformerKit

[![Build Status][build-shield]][build-url]
[![Swift 5.1][swift-shield]][swift-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![Sponsor][sponsor-shield]][sponsor-url]
<a href="https://www.patreon.com/phimage">
<img src="https://c5.patreon.com/external/logo/become_a_patron_button.png" alt="Become a Patron!" height="20">
</a>
<a href="https://paypal.me/ericphimage">
<img src="https://buymecoffee.intm.org/img/button-paypal-white.png" alt="Buy me a coffee" height="20">
</a>

A closure and protocol based framework for [`ValueTransformer`](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html), helpful functions to register `ValueTransformer` by identifier.

See [Some implementations](#some-implementations)

## Create a `ValueTransformer`
### Using closures
```swift
let transformer = ValueTransformer.closure { object in
   return ...
}
```
A `ValueTransformer` subclass is no more necessary using this method.

### Using protocol implementation
Implement `ValueTransformerType` or `ResersableValueTransformerType` and an a computed property `transformer` will be accessible.

#### Using enum
Define your `enum`, a list of all your enum case in `transformers`, implement the function `transformedValue` of `ValueTransformerType` protocol
```swift
enum StringTransformers: String, ValueTransformers, ValueTransformerType {
    case capitalized, lowercased, uppercased

    public static let transformers: [StringTransformers] = [.capitalized, .lowercased, .uppercased]

    public func transformedValue(_ value: Any?) -> Any? { ../* string manipulation */ }
}
```

## Register it
You can retrieve a value transformer using optional initializer of `ValueTransformer`: `init?(forName: NSValueTransformerName)`

A protocol `ValueTransformerRegisterable` help you to register your  `ValueTransformer`
By providing a value transformer and an identifier `name`, a new method will be available
```swift
myValueTransformer.register()
```

So just defined an identifier `name` in your `ValueTransformerType`
```swift
struct MyTransformer: ValueTransformerType, ValueTransformerRegisterable {
    var name = NSValueTransformerName(rawValue: "MyTransformation")
```

### For a singleton instance
You can define a singleton instance using `ValueTransformerSingleton`
```swift
struct MyTransformer: ValueTransformerType, ValueTransformerRegisterable, ValueTransformerSingleton {
    var name = NSValueTransformerName(rawValue: "MyTransformation")
    public static let instance = MyTransformer()
```
or a static function will help you to register it
```swift
MyTransformer.register() // same as MyTransformer.instance.register()
```

### For the previous enum example
```swift
enum StringTransformers: String, ValueTransformers, ValueTransformerType {
  ...
  var name: NSValueTransformerName {
     return NSValueTransformerName("String" + self.rawValue.capitalized)
  }
```
then you can register one by one
```swift
StringTransformers.capitalized.register()
```
or all case
```swift
StringTransformers.register()
```

## Some implementations ##

### String

- capitalized
- uppercased
- lowercased

### Image

- PNG Representation
- JPEG Representation

### Date and Time

- [RFC 2822](https://www.ietf.org/rfc/rfc2822) Timestamp*
- Using  `DateFormatter.Style`

### Number

- Using `NumberFormatter.Style`

### Locale component

- Using `NSLocale.Key`

### Check if empty or not

- Using `IsEmpty`(resp. `IsNotEmpty`) you could transform `String`, `NSString`, `Array`, `NSArray`, `Dictionnary`, etc... to boolean. `true`(resp. `false`) if empty

## Apple Doc
https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html

## License

ValueTransformerKit is available under the MIT license. See the LICENSE file for more info.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[stars-shield]: https://img.shields.io/github/stars/phimage/ValueTransformerKit.svg?style=flat
[stars-url]: https://github.com/phimage/ValueTransformerKit/stargazers
[issues-shield]: https://img.shields.io/github/issues/phimage/ValueTransformerKit.svg?style=flat
[issues-url]: https://github.com/phimage/ValueTransformerKit/issues
[license-shield]: https://img.shields.io/github/license/phimage/ValueTransformerKit.svg?style=flat
[license-url]: https://github.com/phimage/ValueTransformerKit/blob/master/LICENSE
[swift-shield]: https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat
[swift-url]: https://developer.apple.com/swift/
[build-shield]: https://github.com/phimage/ValueTransformerKit/workflows/CI/badge.svg
[build-url]: https://github.com/phimage/ValueTransformerKit/actions?workflow=CI
[sponsor-shield]: https://img.shields.io/badge/Sponsor-%F0%9F%A7%A1-white.svg?style=flat
[sponsor-url]: https://github.com/sponsors/phimage
