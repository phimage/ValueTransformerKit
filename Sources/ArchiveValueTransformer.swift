//
//  ArchiveTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation
@objc(ArchiveValueTransformer)
public final class ArchiveValueTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton {

    open var name = NSValueTransformerName(rawValue: "Archive")
    public static let instance = ArchiveValueTransformer()

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

    public override var reverse: ValueTransformer {
        return UnarchiveValueTransformer.instance
    }

}

@objc(UnarchiveValueTransformer)
public final class UnarchiveValueTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton {

    open var name = NSValueTransformerName(rawValue: "Unarchive")
    public static let instance = UnarchiveValueTransformer()

    open override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let value = value else {
            return nil
        }
        return NSKeyedArchiver.archivedData(withRootObject: value)
    }

    public override var reverse: ValueTransformer {
        return ArchiveValueTransformer.instance
    }

}
