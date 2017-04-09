//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

/// Transform to Boolean by checking if empty
open class IsEmptyTransformer: ValueTransformer {

    open override class func allowsReverseTransformation() -> Bool {
        return false
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let object = value as? Emptyable else {
            return false
        }
        return object.isEmpty
    }

}

/// Transform to Boolean by checking if not empty
open class IsNotEmptyTransformer: ValueTransformer {

    open override class func allowsReverseTransformation() -> Bool {
        return false
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let object = value as? Emptyable else {
            return false
        }
        return !object.isEmpty
    }

}

/// Protocol to know if object is empty
public protocol Emptyable {
    var isEmpty: Bool { get }
}

extension String: Emptyable {}
extension Array: Emptyable {}
extension Set: Emptyable {}
extension Dictionary: Emptyable {}
extension Optional where Wrapped: Emptyable {

    var isEmpty: Bool {
        switch self {
        case .some(let wrapped):
            return wrapped.isEmpty

        case .none:
            return true
        }
    }

}
