//
//  ImageCollectionViewCell.swift
//  TSWebImageView_Example
//
//  Created by Tiago Oliveira on 04/04/21.
//

import UIKit
import TSWebImageView

class ImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var webImage: TSWebImageView! {
        didSet {
            webImage.maxWidth = 200
            webImage.maxHeight = 200
            webImage.hasSkeleton = true
            webImage.contentMode = .scaleAspectFill
            webImage.clipsToBounds = true
            webImage.layer.borderWidth = 1
            webImage.layer.borderColor = UIColor.lightGray.cgColor
            webImage.layer.cornerRadius = 4
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
