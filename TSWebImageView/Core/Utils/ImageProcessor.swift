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
    
}
