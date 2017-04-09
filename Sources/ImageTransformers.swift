//
//  ImageTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import UIKit
// TODO make for Cocoa

public enum ImageToRepresentationTransformers: String, ValueTransformers, ResersableValueTransformerType {

    case png
    case jpeg

    public static let transformers: [ImageToRepresentationTransformers] = [.png, .jpeg]
    public static var kJPEGRepresentationCompressionQuality: CGFloat = 0.85

    public var name: NSValueTransformerName {
        return NSValueTransformerName("ImageRepresentationTransformer" + self.rawValue.capitalized)
    }

    public func transform(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else {
            return nil
        }
        switch self {
        case .png: return UIImagePNGRepresentation(image)
        case .jpeg: return UIImageJPEGRepresentation(image, ImageToRepresentationTransformers.kJPEGRepresentationCompressionQuality)
        }
    }

    public func reverseTransform(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return UIImage.init(data: data)
    }

}

public enum RepresentationToImageTransformers: String, ValueTransformers, ResersableValueTransformerType {

    case png
    case jpeg

    public static let transformers: [RepresentationToImageTransformers] = [.png, .jpeg]

    public var name: NSValueTransformerName {
        return NSValueTransformerName("RepresentationToImageTransformer" + self.rawValue.capitalized)
    }

    // CLEAN factorize with the other transformer
    public func reverseTransform(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else {
            return nil
        }
        switch self {
        case .png: return UIImagePNGRepresentation(image)
        case .jpeg: return UIImageJPEGRepresentation(image, ImageToRepresentationTransformers.kJPEGRepresentationCompressionQuality)
        }
    }

    public func transform(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return UIImage.init(data: data)
    }

}
