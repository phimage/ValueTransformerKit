//
//  ValueTransformers.swift
//  ValueTransformerKit
//
//  Created by Eric Marchand on 26/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

/// Protocol to implement to define a list of transformers.
public protocol ValueTransformers: ValueTransformerRegisterable {

    /// List of transformers
    static var transformers: [Self] {get}

}

/// Specific `ValueTransformers` with only one value transformer instance.
public protocol ValueTransformerSingleton: ValueTransformers {

    static var instance: Self { get }

}
extension ValueTransformerSingleton {

    /// List of transformers containing only self.
    public static var transformers: [Self] {
        return [instance]
    }
}

extension ValueTransformers {

    /// Registers all value transformers.
    public static func register() {
        for transformer in transformers {
            transformer.register()
        }
    }

}

public protocol ReversableValueTransformers: ValueTransformers {

    /// Return a name for reverse value transformer to register it.
    static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName

}

extension ReversableValueTransformers {

    /// Registers all value transformers and the reverse ones.
    public static func register() {
        for transformer in transformers {
            transformer.register()
        }
        for transformer in transformers {
            let reverseTransfomers = ReverseValueTransformer(transformer: transformer.transformer)
            let name = reversableName(from: transformer.name)

            reverseTransfomers.setValueTransformer(forName: name)
        }
    }

}
