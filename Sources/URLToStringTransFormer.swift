//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class URLToStringTransFormer: ValueTransformer {

    open override class func transformedValueClass() -> AnyClass {
        return String.self as! AnyClass
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let url = value as? URL else {
            return nil
        }
        return url.path
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        return URL(string: string)
    }
}
