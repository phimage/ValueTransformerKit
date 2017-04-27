# ValueTransformerKit

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat
            )](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-ios/macos-lightgrey.svg?style=flat
             )](https://developer.apple.com/resources/)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat
             )](https://developer.apple.com/swift)

A closure and protocol based framework for `ValueTransformer`, helpful functions to register `ValueTransformer` by identifier.


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

## Some implementations

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

## Apple Doc
https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html

## License

ValueTransformerKit is available under the MIT license. See the LICENSE file for more info.
