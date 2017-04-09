//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

class NumberToBoolTransformer: ValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return NSNumber.self
    }

    override func transformedValue(_ value: Any?) -> Any? {
        if let number = value as? NSNumber {
            return number.boolValue
        }
        return nil
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let boolValue = value as? Bool {
            return NSNumber(value: boolValue)
        }

        return nil
    }

    public override class func allowsReverseTransformation() -> Bool {
        return true
    }

}

class BoolToNumberTransformer: ValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return NSNumber.self
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let number = value as? NSNumber {
            return number.boolValue
        }
        return nil
    }

    override func transformedValue(_ value: Any?) -> Any? {
        if let boolValue = value as? Bool {
            return NSNumber(value: boolValue)
        }

        return nil
    }

    public override class func allowsReverseTransformation() -> Bool {
        return true
    }

}
