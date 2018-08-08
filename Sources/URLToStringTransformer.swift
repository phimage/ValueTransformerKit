//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

final class URLToStringTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton {

    public var name = NSValueTransformerName(rawValue: "URLToString")
    public static let instance = URLToStringTransformer()

    public override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    public override class func allowsReverseTransformation() -> Bool {
        return true
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let url = value as? URL else {
            return nil
        }
        return url.absoluteString
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        return URL(string: string)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        return NSValueTransformerName("StringToURL")
    }
}
