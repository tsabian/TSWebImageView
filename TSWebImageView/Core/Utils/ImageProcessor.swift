//
//  ImageProcessor.swift
//  TSWebImageView
//
//  Created by Tiago Oliveira on 03/04/21.
//

import Foundation

final class ImageProcessor {
    
    private init() { }
    
    static var shared = ImageProcessor()
    
    func resize(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage? {
        let originalWidth = image.size.width
        let aspectRatio = originalWidth / image.size.height
        var smallSize: CGSize
        if aspectRatio > 1 {
            smallSize = CGSize(width: width, height: height / aspectRatio)
        } else {
            smallSize = CGSize(width: width * aspectRatio, height: height)
        }
        UIGraphicsBeginImageContextWithOptions(smallSize, false, CGFloat.zero)
        image.draw(in: CGRect(x: CGFloat.zero, y: CGFloat.zero, width: smallSize.width, height: smallSize.height), blendMode: .normal, alpha: 1)
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return smallImage
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        let cgImage = image.cgImage!
        let contextImage = UIImage(cgImage: cgImage)
        let contextSize = contextImage.size
        var posX = CGFloat.zero
        var posY = CGFloat.zero
        var cgWidth = CGFloat(width)
        var cgHeight = CGFloat(height)
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = CGFloat.zero
            cgWidth = contextSize.height
            cgHeight = contextSize.height
        } else {
            posX = CGFloat.zero
            posY = ((contextSize.height - contextSize.width) / 2)
            cgWidth = contextSize.width
            cgHeight = contextSize.width
        }
        let rect = CGRect(x: posX, y: posY, width: cgWidth, height: cgHeight)
        let imageRef = cgImage.cropping(to: rect)!
        let image = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        return image
    }
    
}
