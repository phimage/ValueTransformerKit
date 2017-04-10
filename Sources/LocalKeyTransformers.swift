//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

extension NSLocale.Key: ValueTransformers, ValueTransformerType {

    public static let transformers: [NSLocale.Key] = [.identifier, .languageCode, .countryCode, .scriptCode, .variantCode, .exemplarCharacterSet, .calendar, .collationIdentifier, .usesMetricSystem, .measurementSystem, .decimalSeparator, .groupingSeparator, .currencySymbol, .currencyCode, .collatorIdentifier, .quotationBeginDelimiterKey, .quotationEndDelimiterKey, .alternateQuotationBeginDelimiterKey, .alternateQuotationEndDelimiterKey]

    public static var namePrefix = "Locale"

    public var name: NSValueTransformerName {
        var name = self.rawValue
        name = name.replacingOccurrences(of: "kCFLocale", with: "")
        name = name.replacingOccurrences(of: "Key", with: "")
        
        if self.rawValue == name {
            name = name.capitalized
        }
        return NSValueTransformerName(NSLocale.Key.namePrefix + name)
    }
 
    public func transform(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        return Locale.current.displayName(forKey: self, value: string)
    }

}

fileprivate extension Locale {

    func displayName(forKey key: NSLocale.Key, value: Any) -> String? {
        return (self as NSLocale).displayName(forKey: key, value: value)
    }

}
