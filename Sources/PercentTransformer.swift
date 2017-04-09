//
//  PercentTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

@objc(PercentTransformer)
class PercentTransformer: ValueTransformer {

    let numberFormatter = NumberFormatter()

    override init() {
        numberFormatter.numberStyle = NumberFormatter.Style.percent
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        if let d = value as? Double {
            return numberFormatter.string(from: NSNumber(value: d))
        }
        return nil
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let d = value as? String {
            return numberFormatter.number(from: d)
        }
        return nil
    }

}
