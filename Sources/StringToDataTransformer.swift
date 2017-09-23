//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class StringToDataTransformer: ValueTransformer, ValueTransformerRegisterable {

    let encoding: String.Encoding

    open var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "StringToData\(encoding.descriptionForTransformer.capitalized)") }

    public init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        if let string = value as? String {
            return string.data(using: encoding)
        } else {
            return Data() // nil
        }
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let data = value as? Data {
            return String(data: data, encoding: encoding)
        } else {
            return "" // nil
        }
    }

}

open class DataToStringTransformer: StringToDataTransformer {

    open override var name: NSValueTransformerName { return NSValueTransformerName(rawValue: "DataToString\(encoding.descriptionForTransformer.capitalized)") }

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
