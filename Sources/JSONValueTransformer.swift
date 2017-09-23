//
//  JSONValueTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

/// A Codable to JSON data transformer
open class JSONValueTransformer<T: Codable>: ValueTransformer, ValueTransformerRegisterable {

    open var name: NSValueTransformerName {
        return NSValueTransformerName(rawValue: "JSON\(T.self)")
    }

    let encoder: JSONEncoder
    let decoder: JSONDecoder

    public init(encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
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

    /// Return a new encoder, which encode to `String` using `encoding`
    open func with(encoding: String.Encoding) -> ValueTransformer {
        return CompoundValueTransformer(transformers: [self, encoding.transformer])
    }

}

// Just a sample concrete class
class ArrayStringJSONValueTransformer: JSONValueTransformer<[String]> {}
