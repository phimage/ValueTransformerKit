//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

/// Transform to Boolean by checking if empty
@objc(IsEmptyTransformer)
final public class IsEmptyTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton {

    public var name = NSValueTransformerName(rawValue: "IsEmpty")
    public static let instance = IsEmptyTransformer()

    public override class func allowsReverseTransformation() -> Bool {
        return false
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let object = value as? Emptyable else {
            return false
        }
        return object.isEmpty
    }

}

extension IsEmptyTransformer: ValueTransformerReversable {

    public var reverseInstance: ValueTransformer {
        return IsNotEmptyTransformer.instance
    }

}

/// Transform to Boolean by checking if not empty
@objc(IsNotEmptyTransformer)
final public class IsNotEmptyTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton {

    public var name = NSValueTransformerName(rawValue: "IsNotEmpty")
    public static let instance = IsNotEmptyTransformer()

    public override class func allowsReverseTransformation() -> Bool {
        return false
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let object = value as? Emptyable else {
            return false
        }
        return !object.isEmpty
    }

}

extension IsNotEmptyTransformer: ValueTransformerReversable {

    public var reverseInstance: ValueTransformer {
        return IsEmptyTransformer.instance
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
extension NSString: Emptyable {
    public var isEmpty: Bool {
        return length == 0
    }
}

public protocol EmptyableByCount: Emptyable {
    var count: Int { get }
}
extension EmptyableByCount {

    public var isEmpty: Bool {
        return self.count == 0 // swiftlint:disable:this empty_count
    }
}

extension NSArray: EmptyableByCount {}
extension NSSet: EmptyableByCount {}
extension NSDictionary: EmptyableByCount {}
