//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

/// Identity transformer do return the value without applying any transformation
@objc(IdentityTransformer)
final public class IdentityTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton {

    public var name = NSValueTransformerName(rawValue: "Identity")
    public static let instance = IdentityTransformer()

    public override class func transformedValueClass() -> AnyClass {
        return NSObject.self
    }

    public override class func allowsReverseTransformation() -> Bool {
        return true
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        return value
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        return value
    }

}

extension ValueTransformer {
    /// Identity transformer do return the value without applying any transformation
    public static var identity: IdentityTransformer {
        return IdentityTransformer.instance
    }
}

extension IdentityTransformer: ValueTransformerReversable {

    public var reverseInstance: ValueTransformer {
        return self
    }

}
