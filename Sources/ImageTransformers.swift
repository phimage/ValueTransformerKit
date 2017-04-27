//
//  ImageTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

// TODO make ImageTransformer for Cocoa

public enum ImageRepresentationTransformers: String, ReversableValueTransformers, ResersableValueTransformerType {

    case png
    case jpeg

    public static let transformers: [ImageRepresentationTransformers] = [.png, .jpeg]

    public static var kJPEGRepresentationCompressionQuality: CGFloat = 0.85

    public static var namePrefix = "ImageRepresentation"
    public static var reversableNamePrefix = "RepresentationToImage"

    public var name: NSValueTransformerName {
        return NSValueTransformerName(ImageRepresentationTransformers.namePrefix + self.rawValue.capitalized)
    }

    public func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else {
            return nil
        }
        switch self {
        case .png: return UIImagePNGRepresentation(image)
        case .jpeg: return UIImageJPEGRepresentation(image, ImageRepresentationTransformers.kJPEGRepresentationCompressionQuality)
        }
    }

    public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return UIImage.init(data: data)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        let newName = name.rawValue.replacingOccurrences(of: ImageRepresentationTransformers.namePrefix, with: ImageRepresentationTransformers.reversableNamePrefix)
        return NSValueTransformerName(newName)
    }

}
#endif
