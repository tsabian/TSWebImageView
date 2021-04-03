//
//  TSWebImageView.swift
//  TSWebImageView
//
//  Created by Tiago Oliveira on 03/04/21.
//

import UIKit

public final class TSWebImageView: UIImageView {

    // MARK: - Cache
    fileprivate static var ramImageCache = NSCache<NSURL, UIImage>()
    static subscript(url: URL) -> UIImage? {
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

    // MARK: - Inspectable
    @IBInspectable
    var webURLstring: String? {
        didSet {
            guard let webURLstring = webURLstring, !webURLstring.isEmpty, let url = URL(string: webURLstring) else {
                return
            }
            webURL = url
        }
    }

    // MARK: - properties
    private var webURL: URL? {
        didSet {
            guard let url = webURL else {
                return
            }
            if let imageCached = TSWebImageView[url] {
                image = imageCached
            } else {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url), let downloaded = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.image = downloaded
                            TSWebImageView[url] = downloaded
                        }
                    }
                }
            }
        }
    }
    
}
