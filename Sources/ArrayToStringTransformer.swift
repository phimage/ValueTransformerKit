//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

final public class ArrayToStringTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton, ReversableValueTransformers {

    public static var namePrefix = "ArrayToString"
    public static var reversableNamePrefix = "StringToArray"

    public var name = NSValueTransformerName(rawValue: ArrayToStringTransformer.namePrefix)
    public static let instance = ArrayToStringTransformer()

    let separator: String

    public init(separator: String = " ") {
        self.separator = separator
    }

    public override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }

    public override class func allowsReverseTransformation() -> Bool {
        return true
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let randomArray = value as? [String] else {
            return nil
        }
        return randomArray.joined(separator: separator)
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let randomString = value as? String else {
            return nil
        }
        return randomString.components(separatedBy: separator)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        return NSValueTransformerName(ArrayToStringTransformer.reversableNamePrefix)
    }

}
