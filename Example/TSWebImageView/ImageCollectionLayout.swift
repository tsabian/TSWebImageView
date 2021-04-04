//
//  ImageCollectionLayout.swift
//  TSWebImageView_Example
//
//  Created by Tiago Oliveira on 04/04/21.
//

import UIKit

class ImageCollectionLayout: UICollectionViewFlowLayout {

    private var bounds: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    let size: CGSize

    override init() {
        self.size = CGSize(width: 0, height: 0)
        super.init()
    }

    required init?(coder: NSCoder) {
        self.size = CGSize(width: 0, height: 0)
        super.init(coder: coder)
    }

    init(size: CGSize) {
        self.size = size
        super.init()
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        bounds = collectionView.bounds
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        itemSize = size
    }

}
