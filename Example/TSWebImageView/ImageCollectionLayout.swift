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

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return CGPoint() }

        var offsetAdj = MAXFLOAT
        let horizontalOffset = Float(proposedContentOffset.x + 0.5)

        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: 0,
                                width: collectionView.bounds.size.width,
                                height: collectionView.bounds.size.height)

        guard let array = layoutAttributesForElements(in: targetRect) else { return CGPoint() }

        for item in array {
            let itemOffset = Float(item.frame.origin.x)
            if abs(itemOffset - horizontalOffset) < abs(offsetAdj) {
                offsetAdj = Float(itemOffset - horizontalOffset)
            }
        }

        return CGPoint(x: proposedContentOffset.x + CGFloat(offsetAdj), y: proposedContentOffset.y)
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        bounds = collectionView.bounds
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        itemSize = size
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        scrollDirection = .horizontal
    }

}
