//
//  Operators.swift
//  ValueTransformerKit
//
//  Created by phimage on 23/09/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

open class CompoundValueTransformer: ValueTransformer, ExpressibleByArrayLiteral {

    public let transformers: [ValueTransformer]

    public init(transformers: [ValueTransformer]) {
        self.transformers = transformers.isEmpty ? [.identity] : transformers
    }

    public typealias ArrayLiteralElement = ValueTransformer

    public required init(arrayLiteral elements: ValueTransformer...) {
        self.transformers = elements
    }

    open override class func transformedValueClass() -> Swift.AnyClass {
        return NSObject.self
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        var current = value
        for transformer in transformers {
            current = transformer.transformedValue(current)
        }
        return current
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        var current = value
        for transformer in transformers.reversed() {
            current = transformer.reverseTransformedValue(current)
        }
        return current
    }
}

precedencegroup ApplicativeSequencePrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
    lowerThan: NilCoalescingPrecedence
}
infix operator <*  : ApplicativeSequencePrecedence
infix operator  *> : ApplicativeSequencePrecedence

extension ValueTransformer {

    /// Add two value transformers
    public static func + (left: ValueTransformer, right: ValueTransformer) -> ValueTransformer {
        return CompoundValueTransformer(transformers: [left, right])
    }
    public static func + (left: ValueTransformer, right: ValueTransformerType) -> ValueTransformer {
        return CompoundValueTransformer(transformers: [left, right.transformer])
    }

    /// Transform `value` using reverse of `transformer`
    public static func <* <T, U> (transformer: ValueTransformer, value: T) -> U? {
        return transformer.reverseTransformedValue(value) as? U
    }

    /// Transform `value` using `transformer`
    public static func *> <T, U> (value: T, transformer: ValueTransformer) -> U? {
        return transformer.transformedValue(value) as? U
    }

    /// Return the reverse transformer
    public static prefix func ! (transformer: ValueTransformer) -> ValueTransformer {
        return transformer.reverse
    }

}
extension ValueTransformerType {
    public static func + (left: ValueTransformerType, right: ValueTransformerType) -> ValueTransformer {
        return CompoundValueTransformer(transformers: [left.transformer, right.transformer])
    }
}
