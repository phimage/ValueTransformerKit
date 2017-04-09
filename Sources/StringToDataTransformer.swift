//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class StringToDataTransformer: ValueTransformer {

    let encoding: String.Encoding

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
