//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
class URLStringToImageTransformer: ValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return UIImage.self
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value as? String else {
            return nil
        }

        return UIImage(contentsOfFile: value) // add Bundle?
    }
}
#endif
