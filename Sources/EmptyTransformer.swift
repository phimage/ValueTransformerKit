//
//  EmptyStringTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

/// Replace all nil object to ""
open class EmptyStringTransformer: ValueTransformer {

    open func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    open func allowsReverseTransformation() -> Bool {
        return false
    }

    open override func transformedValue(_ object: Any?) -> Any? {
        guard let obj = object else {
            return ""
        }
        return obj
    }

}

/// Replace all nil object to a new object created using `initClosure`
open class EmptyTransformer: ValueTransformer {

    var initClosure: () -> Any

    public init(initClosure: @escaping () -> Any) {
        self.initClosure = initClosure
    }

    open func allowsReverseTransformation() -> Bool {
        return false
    }

    open override func transformedValue(_ object: Any?) -> Any? {
        guard let object = object else {
            return initClosure()
        }
        return object
    }

}
