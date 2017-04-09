//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import Foundation

public enum StringTransformers: String, ValueTransformers, ValueTransformerType {

    case capitalized
    case lowercased
    case uppercased

    public static let transformers: [StringTransformers] = [.capitalized, .lowercased, .uppercased]

    public var name: NSValueTransformerName {
        return NSValueTransformerName("StringTransformer" + self.rawValue.capitalized)
    }

    public func transform(_ value: Any?) -> Any? {
        guard let string = value as? String else {
            return nil
        }
        switch self {
        case .capitalized: return string.capitalized
        case .lowercased: return string.lowercased()
        case .uppercased: return string.uppercased()
        }
    }

}
