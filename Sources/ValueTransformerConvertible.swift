//
//  ValueTransformerConvertible.swift
//  ValueTransformerKit
//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

public protocol ValueTransformerConvertible {

    var transformer: ValueTransformer {get}
    var name: NSValueTransformerName {get}

}

extension ValueTransformerConvertible {

    public func setValueTransformer() {
        ValueTransformer.setValueTransformer(self.transformer, forName: self.name)
    }

}

public protocol ValueTransformers: ValueTransformerConvertible {

    static var transformers: [Self] {get}

}

extension ValueTransformers {

    public static func setValueTransformers() {
        for transformer in transformers {
            transformer.setValueTransformer()
        }
    }

}

public protocol ValueTransformerType {
    func transform(_ value: Any?) -> Any?

}
extension ValueTransformerType {
    public var transformer: ValueTransformer {
        return ValueTransformer.closure(forwardTransformer: self.transform)
    }
}

public protocol ResersableValueTransformerType: ValueTransformerType {
    func reverseTransform(_ value: Any?) -> Any?

}

extension ResersableValueTransformerType {
    public var transformer: ValueTransformer {
        return ValueTransformer.closure(forwardTransformer: self.transform, reverseTransformer: self.reverseTransform)
    }
}
