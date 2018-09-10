//
//  ImageTransformer.swift
//  ValueTransformerKit
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    typealias ValueImage = UIImage

      func ImagePNGRepresentation(_ image: ValueImage) -> Data? {
        #if swift(>=4.2)
        return image.pngData()
        #else
        return UIImagePNGRepresentation(image)
        #endif
    }

    func ImageJPEGRepresentation(_ image: ValueImage, _ compressionFactor: CGFloat) -> Data? {
        #if swift(>=4.2)
        return image. jpegData(compressionQuality: compressionFactor)
        #else
        return UIImageJPEGRepresentation(image, compressionFactor)
        #endif
    }

#elseif os(macOS)
    import Cocoa
    typealias ValueImage = NSImage

    extension NSBitmapImageRep {
        var png: Data? { return representation(using: .png, properties: [:]) }
        func jpeg(compressionFactor: CGFloat) -> Data? {
            return representation(using: .jpeg, properties: [NSBitmapImageRep.PropertyKey.compressionFactor: compressionFactor])
        }
    }
    extension Data {
        var bitmap: NSBitmapImageRep? { return NSBitmapImageRep(data: self) }
    }
    func ImagePNGRepresentation(_ image: ValueImage) -> Data? {
        return image.tiffRepresentation?.bitmap?.png
    }

    func ImageJPEGRepresentation(_ image: ValueImage, _ compressionFactor: CGFloat) -> Data? {
        return image.tiffRepresentation?.bitmap?.jpeg(compressionFactor: compressionFactor)
    }
#endif

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
        guard let image = value as? ValueImage else {
            return nil
        }
        switch self {
        case .png: return ImagePNGRepresentation(image)
        case .jpeg: return ImageJPEGRepresentation(image, ImageRepresentationTransformers.kJPEGRepresentationCompressionQuality)
        }
    }

    public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        return ValueImage.init(data: data)
    }

    public static func reversableName(from name: NSValueTransformerName) -> NSValueTransformerName {
        let newName = name.rawValue.replacingOccurrences(of: ImageRepresentationTransformers.namePrefix, with: ImageRepresentationTransformers.reversableNamePrefix)
        return NSValueTransformerName(newName)
    }

}
