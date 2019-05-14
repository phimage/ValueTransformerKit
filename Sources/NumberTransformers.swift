//
//  PercentTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

public enum NumberTransformers: ReversableValueTransformers, ResersableValueTransformerType {

    case numberStyle(NumberFormatter.Style)
    case formatter(NumberFormatter)
    case numberFormat(String)

    public static let transformers: [NumberTransformers] = {
        let styles: [NumberFormatter.Style] =  [.none, .decimal, .percent, .scientific, .spellOut, .ordinal,
                                                .currency, .currencyISOCode, .currencyPlural, .currencyAccounting]
        return styles.map { .numberStyle($0) }
    }()

    public static var namePrefix = "Number"
    public static var reversableNamePrefix = "StringToNumber"

    public var formatter: NumberFormatter {
        switch self {
        case .numberStyle(let style): return NumberFormatter.with(style: style)
        case .formatter(let formatter): return formatter
        case .numberFormat(let format):
            let formatter = NumberFormatter()
            formatter.positiveFormat = format
            return formatter
        }
    }

    public var numberStyle: NumberFormatter.Style {
        switch self {
        case .numberStyle(let style): return style
        case .formatter(let formatter): return formatter.numberStyle
        default: return self.formatter.numberStyle
        }
    }

    public var description: String {
        switch self {
        case .numberStyle(let style): return "\(style.description)"
        case .formatter(let formatter): return "formatter" + formatter.positiveFormat
        case .numberFormat(let format): return "numberFormat" + format
        }
    }

    public var name: NSValueTransformerName {
        if case .numberStyle(.none) = self {
            return NSValueTransformerName(NumberTransformers.namePrefix)
        }
        return NSValueTransformerName(NumberTransformers.namePrefix + self.description.capitalized)
    }

    public func transformedValue(_ value: Any?) -> Any? {
        guard let number = value as? NSNumber else {
            return nil
        }
        return formatter.string(for: number)
    }

    public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        return formatter.number(from: string)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        let newName = name.rawValue.replacingOccurrences(of: NumberTransformers.namePrefix, with: NumberTransformers.reversableNamePrefix)
        return NSValueTransformerName(newName)
    }

}

fileprivate extension NumberFormatter {

    static func with(style: NumberFormatter.Style) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        return formatter
    }

}

fileprivate extension NumberFormatter.Style {
    var description: String {
        switch self {
        case .none: return "none"
        case .decimal: return "decimal"
        case .currency: return "currency"
        case .percent: return "percent"
        case .scientific: return "scientific"
        case .spellOut: return "spellOut"
        case .ordinal: return "ordinal"
        case .currencyISOCode: return "currencyISOCode"
        case .currencyPlural: return "currencyPlural"
        case .currencyAccounting: return "currencyAccounting"
            #if swift(>=5.0)
        @unknown default:
            fatalError("No string description for NumberFormatter.Style \(self)")
            #endif
        }
    }
}
