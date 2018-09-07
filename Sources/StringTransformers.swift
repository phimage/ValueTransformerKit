//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

public enum StringTransformers: ValueTransformers, ValueTransformerType {

    case capitalized
    case lowercased
    case uppercased
    case format(String)
    case localized(Bundle)

    var rawValue: String {
        switch self {
        case .capitalized: return "capitalized"
        case .lowercased: return "lowercased"
        case .uppercased: return "uppercased"
        case .format(let format): return "format"+format
        case .localized(let bundle):
            if bundle == Bundle.main {
                return "localized"
            }
            return "localized"+bundle.bundlePath
        }
    }

    public static let transformers: [StringTransformers] = [.capitalized, .lowercased, .uppercased, .localized(.main)]

    public static var namePrefix = "String"

    public var name: NSValueTransformerName {
        return NSValueTransformerName(StringTransformers.namePrefix + self.rawValue.capitalized)
    }

    public func transformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        switch self {
        case .capitalized: return string.capitalized
        case .lowercased: return string.lowercased()
        case .uppercased: return string.uppercased()
        case .format(let format): return String(format: format, string)
        case .localized(let bundle): return NSLocalizedString(string, bundle: bundle, comment: "")
        }

    }

}

/// String Encoding could transform data to string and string to data
extension String.Encoding: ReversableValueTransformers, ResersableValueTransformerType {

    public static let transformers: [String.Encoding] = [.ascii, .nonLossyASCII, .macOSRoman, .nextstep,
                                                         .windowsCP1250, .windowsCP1251, .windowsCP1252, .windowsCP1253, .windowsCP1254,
                                                         .isoLatin1, .isoLatin2, .iso2022JP, .japaneseEUC, .shiftJIS,
                                                         .utf8, .symbol,
                                                         .utf16/* = .unicode*/, .utf16BigEndian, .utf16LittleEndian,
                                                         .utf32, .utf32BigEndian, .utf32LittleEndian]

    public static var namePrefix = "StringData"

    public var name: NSValueTransformerName {
        return NSValueTransformerName(StringTransformers.namePrefix + self.descriptionForTransformer.capitalized)
    }

    public func transformedValue(_ value: Any?) -> Any? {
        if let string = value as? String {
            return string.data(using: self)
        }
        if let data = value as? Data {
            return String(data: data, encoding: self)
        }
        return nil
    }

    public func reverseTransformedValue(_ value: Any?) -> Any? {
        return transformedValue(value)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        return name
    }

    var descriptionForTransformer: String {
        switch self {
        case .ascii: return "ascii"
        case .nonLossyASCII: return "nonLossyASCII"
        case .iso2022JP: return "iso2022JP"
        case .isoLatin1: return "isoLatin1"
        case .isoLatin2: return "isoLatin2"
        case .japaneseEUC: return "japaneseEUC"
        case .macOSRoman: return "macOSRoman"
        case .nextstep: return "nextstep"
        case .windowsCP1250: return "windowsCP1250"
        case .windowsCP1251: return "windowsCP1251"
        case .windowsCP1252: return "windowsCP1252"
        case .windowsCP1253: return "windowsCP1253"
        case .windowsCP1254: return "windowsCP1254"
        case .shiftJIS: return "shiftJIS"
        case .symbol: return "symbol"
        case .utf8: return "utf8"
        case .utf16/*, .unicode*/: return "utf16"
        case .utf16BigEndian: return "utf16BigEndian"
        case .utf16LittleEndian: return "utf16LittleEndian"
        case .utf32: return "utf32"
        case .utf32BigEndian: return "utf32BigEndian"
        case .utf32LittleEndian: return "utf32LittleEndian"
        default: return self.description
        }
    }

}
