//
//  ISO3166CountryValueTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

open class ISO3166CountryValueTransformer: ValueTransformer {

    open override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    open override class func allowsReverseTransformation() -> Bool {
        return false
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        return Locale.current.displayName(forKey: .countryCode, value: string)
    }

}

extension Locale {

    func displayName(forKey key: NSLocale.Key, value: Any) -> String? {
        return (self as NSLocale).displayName(forKey: key, value: value)
    }

}
