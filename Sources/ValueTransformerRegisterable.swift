//
//  ValueTransformerRegisterable.swift
//  ValueTransformerKit
//
//  Created by phimage on 09/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

/// An helper protocol to register a value transformer.
public protocol ValueTransformerRegisterable {

    /// The value transformer to register.
    var transformer: ValueTransformer {get}
    /// The identifier to register the value transformer.
    var name: NSValueTransformerName {get}
}

extension ValueTransformerRegisterable {

    /// Registers the value transformer.
    public func register() {
        self.transformer.setValueTransformer(forName: self.name)
    }

}

extension ValueTransformerRegisterable where Self: ValueTransformer {
    public var transformer: ValueTransformer {
        return self
    }
}

extension ValueTransformer {

    /// Registers this value transformer with a given identifier.
    open func setValueTransformer(forName name: NSValueTransformerName) {
        assert(ValueTransformer(forName: name) == nil)
        ValueTransformer.setValueTransformer(self, forName: name)
    }

    /// Registers this value transformer with a given identifier.
    open func setValueTransformer(for string: String) {
        self.setValueTransformer(forName: NSValueTransformerName(string))
    }

}
