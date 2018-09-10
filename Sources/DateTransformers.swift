//
//  Created by phimage on 05/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

public enum DateTransformers: ReversableValueTransformers, ResersableValueTransformerType {

    case rfc822
    case short
    case medium
    case long
    case full
    case formatter(DateFormatter)
    case dateFormat(String)

    public static let transformers: [DateTransformers] = [.rfc822, .short, .medium, .long, .full]

    public static var namePrefix = "Date"
    public static var reversableNamePrefix = "StringToDate"

    public var formatter: DateFormatter {
        switch self {
        case .rfc822: return .rfc822
        case .short: return .shortDate
        case .medium: return .mediumDate
        case .long: return .longDate
        case .full: return .fullDate
        case .formatter(let formatter): return formatter
        case .dateFormat(let dateFormat):
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            return formatter
        }
    }

    var description: String {
        switch self {
        case .rfc822: return "rfc822"
        case .short: return "shortDate"
        case .medium: return "mediumDate"
        case .long: return "longDate"
        case .full: return "fullDate"
        case .formatter(let formatter): return "formatter" + formatter.dateFormat
        case .dateFormat(let format): return "dateFormat" + format
        }
    }

    public var name: NSValueTransformerName {
        return NSValueTransformerName(DateTransformers.namePrefix + self.description.capitalized)
    }

    public func transformedValue(_ value: Any?) -> Any? {
        guard let date = value as? Date else {
            return nil
        }
        return formatter.string(for: date)
    }

    public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        return formatter.date(from: string)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        let newName = name.rawValue.replacingOccurrences(of: DateTransformers.namePrefix, with: DateTransformers.reversableNamePrefix)
        return NSValueTransformerName(newName)
    }

}

// MARK: formatter
fileprivate extension DateFormatter {

    static let rfc822: DateFormatter = {
        let formatter = DateFormatter()
        // formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss zzz"
        return formatter
    }()

    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    static let mediumDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    static let longDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()

    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()

}

// MARK: - DateToStringTransformer Class
public class DateToStringTransformer: ValueTransformer {

    // MARK: - formatter
    fileprivate let formatter: DateFormatter

    // MARK: - Init
    public init(formatter: DateFormatter) {
        self.formatter = formatter
        super.init()
    }

    // MARK: - ValueTransformer
    public override class func transformedValueClass() -> Swift.AnyClass {
        return NSDate.self
    }

    public override class func allowsReverseTransformation() -> Bool {
        return true
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let date = value as? Date else {
            return nil
        }
        return formatter.string(for: date)
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        return formatter.date(from: string)
    }

}

public class StringToDateDateTransformer: DateToStringTransformer {

    // MARK: - Init
    public override init(formatter: DateFormatter) {
        super.init(formatter: formatter)
    }

    // MARK: - ValueTransformer
    public override class func transformedValueClass() -> Swift.AnyClass {
        return NSString.self
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        return super.reverseTransformedValue(value)
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        return super.transformedValue(value)
    }

}
