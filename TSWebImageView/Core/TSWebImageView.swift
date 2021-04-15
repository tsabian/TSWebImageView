//
//  TSWebImageView.swift
//  TSWebImageView
//
//  Created by Tiago Oliveira on 03/04/21.
//

import UIKit

public final class TSWebImageView: UIImageView {

    private var darkGrayGradient: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    private var lightGrayGradient: CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Cache

    private static var ramImageCache = NSCache<NSURL, UIImage>()
    
    public static subscript(url: URL) -> UIImage? {
        get {
            guard let currentURL = NSURL(string: url.absoluteString) else {
                return nil
            }
            return ramImageCache.object(forKey: currentURL)
        }
        set {
            guard let currentURL = NSURL(string: url.absoluteString) else {
                return
            }
            if let newImage = newValue {
                ramImageCache.setObject(newImage, forKey: currentURL)
            } else {
                ramImageCache.removeObject(forKey: currentURL)
            }
        }
    }
    
    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupSkeletonUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSkeletonUI()
    }


    // MARK: - Inspectable

    @IBInspectable public var maxWidth: CGFloat = CGFloat.zero

    @IBInspectable public var maxHeight: CGFloat = CGFloat.zero

    @IBInspectable public var webURLstring: String? {
        didSet {
            guard let webURLstring = webURLstring, !webURLstring.isEmpty, let url = URL(string: webURLstring) else {
                return
            }
            webURL = url
        }
    }
    
    @IBInspectable public var hasSkeleton: Bool = false

    // MARK: - properties
    fileprivate var webURL: URL? {
        didSet {
            guard let url = webURL else {
                return
            }
            show()
            if let imageCached = TSWebImageView[url] {
                image = imageCached
                hide()
            } else {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url), let downloaded = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.image = self.prepare(originalImage: downloaded)
                            TSWebImageView[url] = self.image
                            self.hide()
                        }
                    }
                }
            }
        }
    }
     
    // MARK: - functions
    private func prepare(originalImage: UIImage) -> UIImage? {
        if originalImage.size.width > maxWidth || originalImage.size.height > maxHeight {
            return ImageProcessor.shared.resize(image: originalImage, width: maxWidth, height: maxHeight)
        }
        return originalImage
    }

    public static func clearAllFromCache() {
        ramImageCache.removeAllObjects()
    }
    
    private func setupSkeletonUI() {
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [darkGrayGradient, lightGrayGradient, darkGrayGradient]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.masksToBounds = true
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.7
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func show() {
        if hasSkeleton {
            layer.addSublayer(gradientLayer)
        }
    }
    
    func hide() {
        layer.sublayers?.removeLast()
    }
}

public extension TSWebImageView {
    
    func clearFromCache() {
        if let currentURL = webURL {
            TSWebImageView[currentURL] = nil
        }
    }

}
