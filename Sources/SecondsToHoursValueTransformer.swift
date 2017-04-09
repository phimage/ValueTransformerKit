//
//  SecondsToHoursValueTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation
class SecondsToHoursValueTransformer: ValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return NSNumber.self
    }

    override class func allowsReverseTransformation() -> Bool {
        return false
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let timeInterval = value as? NSNumber else { return nil }
        return timeInterval.doubleValue / (60 * 60)
    }

}
