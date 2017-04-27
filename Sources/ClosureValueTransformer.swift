//
//  Created by phimage on 05/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

extension ValueTransformer {

    public class func closure(forwardTransformer: @escaping ClosureValueTransformer.ForwardTransformer) -> ClosureValueTransformer {
        return ClosureValueTransformer(forwardTransformer: forwardTransformer, reverseTransformer: nil)
    }

    public class func closure(forwardTransformer: @escaping ClosureValueTransformer.ForwardTransformer, reverseTransformer: @escaping ClosureValueTransformer.ReverseTransformer) -> ClosureValueTransformer {
        return ReversibleClosureValueTransformer(forwardTransformer: forwardTransformer, reverseTransformer: reverseTransformer)
    }

}

// MARK: - ClosureValueTransformer Class
public class ClosureValueTransformer: ValueTransformer {

    // MARK: - Closure alias
    public typealias ForwardTransformer = (_ value: Any?) -> Any?
    public typealias ReverseTransformer = (_ value: Any?) -> Any?

    // MARK: - Closure
    fileprivate let forwardTransformer: ForwardTransformer
    fileprivate let reverseTransformer: ReverseTransformer?

    // MARK: - Init
    fileprivate init(forwardTransformer: @escaping ForwardTransformer, reverseTransformer: ReverseTransformer?) {
        self.forwardTransformer = forwardTransformer
        self.reverseTransformer = reverseTransformer
        super.init()
    }

    // MARK: - ValueTransformer

    public override class func allowsReverseTransformation() -> Bool {
        return false
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        return self.forwardTransformer(value)
    }

}

// MARK: - ReversibleClosureValueTransformer Class
public class ReversibleClosureValueTransformer: ClosureValueTransformer {

    // MARK: - Init
    fileprivate init(forwardTransformer: @escaping ForwardTransformer, reverseTransformer: @escaping ReverseTransformer) {
        super.init(forwardTransformer: forwardTransformer, reverseTransformer: reverseTransformer)
    }

    // MARK: - ValueTransformer
    final public override class func allowsReverseTransformation() -> Bool {
        return true
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        return self.reverseTransformer!(value)
    }

}
