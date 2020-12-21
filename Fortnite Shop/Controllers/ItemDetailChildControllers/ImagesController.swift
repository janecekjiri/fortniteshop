//
//  ImagesController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ImagesController: UICollectionViewController {

    private let cellId = "cellId"
    private var images = [UIImage]()
    private var rarity = Rarity.unknown

    var didSelectImage: ((UIImage) -> Void)?

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
    }

    func insert(_ images: [UIImage], _ rarity: Rarity) {
        images.forEach { self.images.append($0) }
        self.rarity = rarity
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Setup Methods
extension ImagesController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let imageCell = cell as? ImageCell else {
            return cell
        }
        imageCell.showImage(images[indexPath.item])
        imageCell.backgroundColor = UIColor.rarityColor(for: rarity)
        return imageCell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 10)/2
        return .init(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectImage?(images[indexPath.item])
    }
}
