//
//  Created by phimage on 05/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

// MARK: - ClosureValueTransformer Class
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
