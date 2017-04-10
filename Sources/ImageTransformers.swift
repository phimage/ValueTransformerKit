//
//  ImageTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import UIKit
// TODO make for Cocoa
public enum ImageToRepresentationTransformers: String, ReversableValueTransformers, ResersableValueTransformerType {

    case png
    case jpeg

    public static let transformers: [ImageToRepresentationTransformers] = [.png, .jpeg]

    public static var kJPEGRepresentationCompressionQuality: CGFloat = 0.85

    public static var namePrefix = "ImageRepresentation"
    public static var reversableNamePrefix = "RepresentationToImage"

    public var name: NSValueTransformerName {
        return NSValueTransformerName(ImageToRepresentationTransformers.namePrefix + self.rawValue.capitalized)
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

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        let newName = name.rawValue.replacingOccurrences(of: ImageToRepresentationTransformers.namePrefix, with: ImageToRepresentationTransformers.reversableNamePrefix)
        return NSValueTransformerName(newName)
    }

}
