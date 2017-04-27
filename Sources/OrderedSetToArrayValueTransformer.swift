//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

// allow to bind with nsarraycontroller
@objc(OrderedSetToArrayValueTransformer)
final public class OrderedSetToArrayValueTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton, ReversableValueTransformers {

    public static var namePrefix = "OrderedSetToArray"
    public static var reversableNamePrefix = "ArrayToOrderedSet"

    open var name = NSValueTransformerName(rawValue: OrderedSetToArrayValueTransformer.namePrefix)
    public static let instance = OrderedSetToArrayValueTransformer()

    open override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let set = value as? NSOrderedSet else {
            return nil
        }
        return set.array
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let array = value as? [AnyObject] else {
            return nil
        }
        return NSOrderedSet(array: array)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        return NSValueTransformerName(OrderedSetToArrayValueTransformer.reversableNamePrefix)
    }

}
