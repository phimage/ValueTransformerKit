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

    public var name = NSValueTransformerName(rawValue: "Archive")
    public static let instance = ArchiveValueTransformer()

    public override class func allowsReverseTransformation() -> Bool {
        return true
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value else {
            return nil
        }
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        } catch {
            // XXX add log
            return nil
        }
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }

}

extension ArchiveValueTransformer: ValueTransformerReversable {

    public var reverseInstance: ValueTransformer {
        return UnarchiveValueTransformer.instance
    }

}

@objc(UnarchiveValueTransformer)
public final class UnarchiveValueTransformer: ValueTransformer, ValueTransformerRegisterable, ValueTransformerSingleton {

    public var name = NSValueTransformerName(rawValue: "Unarchive")
    public static let instance = UnarchiveValueTransformer()

    public override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let value = value else {
            return nil
        }
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        } catch {
            // XXX add log
            return nil
        }
    }
}

extension UnarchiveValueTransformer: ValueTransformerReversable {

    public var reverseInstance: ValueTransformer {
        return ArchiveValueTransformer.instance
    }

}
