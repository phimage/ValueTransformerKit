//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class ReverseValueTransformer: ValueTransformer {

    let transformer: ValueTransformer

    public init(transformer: ValueTransformer) {
        self.transformer = transformer
        assert(transformer.classForCoder.allowsReverseTransformation())
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        return transformer.reverseTransformedValue(value)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        return transformer.transformedValue(value)
    }

}
