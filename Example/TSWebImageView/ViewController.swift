//
//  ViewController.swift
//  TSWebImageView
//
//  Created by tsabian on 04/03/2021.
//  Copyright (c) 2021 tsabian. All rights reserved.
//

import UIKit
import TSWebImageView

typealias Image = (index: Int, url: String)

class ViewController: UIViewController {

    fileprivate var images = [Image]()

    // MARK: - Outlets

    @IBOutlet weak var imageCollection: UICollectionView! {
        didSet {
            imageCollection.delegate = self
            imageCollection.dataSource = self
            imageCollection.isPagingEnabled = true
            imageCollection.isScrollEnabled = true
            imageCollection.showsVerticalScrollIndicator = false
            imageCollection.showsHorizontalScrollIndicator = false
            imageCollection.allowsSelection = false
            imageCollection.collectionViewLayout = ImageCollectionLayout(size: CGSize(width: 150, height: 150))
            let cellNib = UINib(nibName: "ImageCollectionViewCell", bundle: .main)
            imageCollection.register(cellNib, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        }
    }
    @IBOutlet weak var reloadButton: UIButton! {
        didSet {
            reloadButton.setTitle("Reload", for: .normal)
            reloadButton.layer.borderWidth = 1
            reloadButton.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.setTitle("Clear", for: .normal)
            resetButton.layer.borderWidth = 1
            resetButton.layer.cornerRadius = 8
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Action
    @IBAction func tapReload(_ sender: UIButton) {
        reload()
    }

    @IBAction func tapClear(_ sender: UIButton) {
        TSWebImageView.clearAllFromCache()
        images.removeAll()
        imageCollection.reloadData()
    }

    // MARK: - Functions
    private func reload() {
        fetch()
        imageCollection.reloadData()
    }

    private func fetch() {
        if images.count > 0 {
            images.removeAll()
        }
        // swiftlint:disable line_length
        images.append(Image(index: 1, url: "https://image.shutterstock.com/image-photo/milky-way-northern-hemisphere-600w-1697802721.jpg"))
        images.append(Image(index: 2, url: "https://image.shutterstock.com/z/stock-photo-kid-self-isolation-using-tablet-for-his-homework-child-doing-using-digital-tablet-searching-1681937335.jpg"))
        images.append(Image(index: 3, url: "https://image.shutterstock.com/image-photo/happy-couple-driving-on-country-600w-305567459.jpg"))
        images.append(Image(index: 4, url: "https://image.shutterstock.com/image-photo/digital-marketing-businessman-using-modern-600w-1053868622.jpg"))
        images.append(Image(index: 5, url: "https://image.shutterstock.com/image-photo/man-using-payments-online-shopping-600w-538336555.jpg"))
        images.append(Image(index: 6, url: "https://image.shutterstock.com/z/stock-photo-standard-construction-safety-383464744.jpg"))
        images.append(Image(index: 7, url: "https://image.shutterstock.com/image-photo/nature-landscape-macro-wallpaper-abstract-600w-1741170125.jpg"))
        images.append(Image(index: 8, url: "https://image.shutterstock.com/image-photo/africa-elephant-zambezi-zambia-600w-1067727128.jpg"))
        images.append(Image(index: 9, url: "https://image.shutterstock.com/z/stock-photo-predator-s-love-lioness-and-cub-in-the-kruger-np-south-africa-1078246298.jpg"))
        images.append(Image(index: 10, url: "https://image.shutterstock.com/z/stock-photo-asiatic-lioness-walking-forward-in-hunting-pouse-1596359590.jpg"))
        // swiftlint:enabled line_length
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let className = String(describing: ImageCollectionViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.webImage.webURLstring = images[indexPath.row].url
        return cell
    }
}
