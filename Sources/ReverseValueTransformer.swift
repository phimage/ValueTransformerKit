//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

/// Reverse the transformation of one `ValueTransformer`
/// `allowsReverseTransformation` must return true
open class ReverseValueTransformer: ValueTransformer {

    let toReverse: ValueTransformer

    public init(transformer: ValueTransformer) {
        self.toReverse = transformer
        assert(transformer.classForCoder.allowsReverseTransformation())
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        return toReverse.reverseTransformedValue(value)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        return toReverse.transformedValue(value)
    }

}

public protocol ValueTransformerReversable {
    var reverseInstance: ValueTransformer {get}
}

extension ValueTransformer {

    /// Return the reverse value transformer. `allowsReverseTransformation` must return true
    public var reverse: ValueTransformer {
        if let reversable = self as? ValueTransformerReversable {
            return reversable.reverseInstance
        }
        return ReverseValueTransformer(transformer: self)
    }

}
