//
//  TimeTransformers.swift
//  ValueTransformerKit
//
//  Created by Eric Marchand on 26/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

public enum TimeTransformers: String, ReversableValueTransformers, ResersableValueTransformerType {

    case short
    case medium
    case long
    case full

    public static let transformers: [TimeTransformers] = [.short, .medium, .long, .full]

    public static var namePrefix = "Time"
    public static var reversableNamePrefix = "StringToTime"

    public var formatter: DateFormatter {
        switch self {
        case .short: return .shortTime
        case .medium: return .mediumTime
        case .long: return .longTime
        case .full: return .fullTime
        }
    }

    public var name: NSValueTransformerName {
        return NSValueTransformerName(TimeTransformers.namePrefix + self.rawValue.capitalized)
    }

    public func transformedValue(_ value: Any?) -> Any? {
        // TODO support timestamp? (here we can, but in reverse we cannot know)
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
        let newName = name.rawValue.replacingOccurrences(of: TimeTransformers.namePrefix, with: TimeTransformers.reversableNamePrefix)
        return NSValueTransformerName(newName)
    }

}

// MARK: formatter
fileprivate extension DateFormatter {

    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    static let mediumTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()

    static let longTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        return formatter
    }()

    static let fullTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .full
        return formatter
    }()
}
