//
//  PropertyListTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 23/09/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import Foundation

open class PropertyListTransformer<T: Codable>: ValueTransformer, ValueTransformerRegisterable {

    open var name: NSValueTransformerName {
        return NSValueTransformerName(rawValue: "PropertyList\(T.self)")
    }

    let encoder: PropertyListEncoder
    let decoder: PropertyListDecoder

    public init(encoder: PropertyListEncoder = PropertyListEncoder(), decoder: PropertyListDecoder = PropertyListDecoder()) {
        self.encoder = encoder
        self.decoder = decoder
    }

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override func transformedValue(_ value: Any?) -> Any? {
        guard let codable = value as? T else {
            return nil
        }
        return try? self.encoder.encode(codable)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return try? self.decoder.decode(T.self, from: data)
    }

}
