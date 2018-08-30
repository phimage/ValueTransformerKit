//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class Base64EncodeDataToStringTransformer: ValueTransformer, ValueTransformerRegisterable {

    open var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "Base64EncodeDataToString") }

    let encodingOptions: Data.Base64EncodingOptions
    let decodingOptions: Data.Base64DecodingOptions

    public init(encodingOptions: Data.Base64EncodingOptions = [], decodingOptions: Data.Base64DecodingOptions = []) {
        self.encodingOptions = encodingOptions
        self.decodingOptions = decodingOptions
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        if let data = value as? Data {
            return data.base64EncodedString(options: encodingOptions)
        } else {
            return nil
        }
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let string = value as? String {
            return Data(base64Encoded: string, options: decodingOptions)
        } else {
            return nil
        }
    }

}

open class Base64DecodeDataFromStringTransformer: Base64EncodeDataToStringTransformer {

    open override var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "Base64DecodeDataFromString") }

    open override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        return super.reverseTransformedValue(value)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        return super.transformedValue(value)
    }

}

open class Base64EncodeTransformer: ValueTransformer, ValueTransformerRegisterable {

    open var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "Base64Encode") }

    let encodingOptions: Data.Base64EncodingOptions
    let decodingOptions: Data.Base64DecodingOptions

    public init(encodingOptions: Data.Base64EncodingOptions = [], decodingOptions: Data.Base64DecodingOptions = []) {
        self.encodingOptions = encodingOptions
        self.decodingOptions = decodingOptions
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        if let data = value as? Data {
            return data.base64EncodedData(options: encodingOptions)
        } else {
            return nil
        }
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let data = value as? Data {
            return Data(base64Encoded: data, options: decodingOptions)
        } else {
            return nil
        }
    }

}

open class Base64DecodeTransformer: Base64EncodeTransformer {

    open override var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "Base64Decode") }

    open override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        return super.reverseTransformedValue(value)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        return super.transformedValue(value)
    }

}

open class Base64EncodeStringTransformer: ValueTransformer, ValueTransformerRegisterable {

    open var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "Base64EncodeString") }

    let encodingOptions: Data.Base64EncodingOptions
    let decodingOptions: Data.Base64DecodingOptions
    let encoding: String.Encoding

    public init(encoding: String.Encoding = .utf8, encodingOptions: Data.Base64EncodingOptions = [], decodingOptions: Data.Base64DecodingOptions = []) {
        self.encoding = encoding
        self.encodingOptions = encodingOptions
        self.decodingOptions = decodingOptions
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        if let string = value as? String {
            return string.data(using: encoding)?.base64EncodedData(options: encodingOptions)
        } else {
            return nil
        }
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let string = value as? String {
            guard let data = Data(base64Encoded: string, options: decodingOptions) else {
                return nil
            }
            return String(data: data, encoding: encoding)
        } else {
            return nil
        }
    }

}

open class Base64DecodeStringTransformer: Base64EncodeStringTransformer {

    open override var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "Base64DecodeString") }

    open override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        return super.reverseTransformedValue(value)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        return super.transformedValue(value)
    }

}
