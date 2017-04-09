//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class ArrayToStringTransformer: ValueTransformer {

    let separator: String

    public init(separator: String = " ") {
        self.separator = separator
    }

    open override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let randomArray = value as? [String] else {
            return nil
        }
        return randomArray.joined(separator: separator)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let randomString = value as? String else {
            return nil
        }
        return randomString.components(separatedBy: separator)
    }

}
