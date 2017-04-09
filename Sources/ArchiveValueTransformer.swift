//
//  ArchiveTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class ArchiveValueTransformer: ValueTransformer {

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value else {
            return nil
        }
        return NSKeyedArchiver.archivedData(withRootObject: value)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
}

open class UnarchiveValueTransformer: ArchiveValueTransformer {

    open override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        return super.reverseTransformedValue(value)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        return super.transformedValue(value)
    }

}
