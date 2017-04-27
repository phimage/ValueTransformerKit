//
//  ValueTransformerType.swift
//  ValueTransformerKit
//
//  Created by Eric Marchand on 26/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

/// A protocol to define a transformation.
public protocol ValueTransformerType {
    func transformedValue(_ value: Any?) -> Any?

}
extension ValueTransformerType {
    /// Return a `ValueTransformer`
    public var transformer: ValueTransformer {
        return ValueTransformer.closure(forwardTransformer: self.transformedValue)
    }
}

/// A protocol to define a reverse transformation.
public protocol ResersableValueTransformerType: ValueTransformerType {
    func reverseTransformedValue(_ value: Any?) -> Any?
}

extension ResersableValueTransformerType {
    /// Return a `ValueTransformer`
    public var transformer: ValueTransformer {
        return ValueTransformer.closure(forwardTransformer: self.transformedValue, reverseTransformer: self.reverseTransformedValue)
    }
}

extension ValueTransformer: ResersableValueTransformerType {
    /// Return self
    public var transformer: ValueTransformer {
        return self
    }
}
