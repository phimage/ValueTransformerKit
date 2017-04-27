//
//  PercentTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

public enum NumberTransformers: String, ReversableValueTransformers, ResersableValueTransformerType {

    case none
    case decimal
    case currency
    case percent
    case scientific
    case spellOut
    case ordinal
    case currencyISOCode
    case currencyPlural
    case currencyAccounting

    public static let transformers: [NumberTransformers] = [.none, .decimal, .currency, .percent, .scientific, .spellOut, .ordinal, .currencyISOCode, .currencyPlural, .currencyAccounting]

    public static var namePrefix = "Number"
    public static var reversableNamePrefix = "StringToNumber"

    public var formatter: NumberFormatter {
        switch self {
        case .none: return .none
        case .decimal: return .decimal
        case .currency: return .currency
        case .percent: return .percent
        case .scientific: return .scientific
        case .spellOut: return .spellOut
        case .ordinal: return .ordinal
        case .currencyISOCode: return .currencyISOCode
        case .currencyPlural: return .currencyPlural
        case .currencyAccounting: return .currencyAccounting
        }
        /*let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        return formatter*/
    }

    public var numberStyle: NumberFormatter.Style {
        switch self {
        case .none: return .none
        case .decimal: return .decimal
        case .currency: return .currency
        case .percent: return .percent
        case .scientific: return .scientific
        case .spellOut: return .spellOut
        case .ordinal: return .ordinal
        case .currencyISOCode: return .currencyISOCode
        case .currencyPlural: return .currencyPlural
        case .currencyAccounting: return .currencyAccounting
        }
    }

    public var name: NSValueTransformerName {
        if case .none = self {
            return NSValueTransformerName(NumberTransformers.namePrefix)
        }
        return NSValueTransformerName(NumberTransformers.namePrefix + self.rawValue.capitalized)
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

    static let none: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()

    static let decimal: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    static let currency: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    static let scientific: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        return formatter
    }()

    static let percent: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()

    static let spellOut: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }()

    static let ordinal: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()

    static let currencyISOCode: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyISOCode
        return formatter
    }()

    static let currencyPlural: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyPlural
        return formatter
    }()

    static let currencyAccounting: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        return formatter
    }()

}
