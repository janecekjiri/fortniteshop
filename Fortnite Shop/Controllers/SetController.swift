//
//  SetController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 20/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class SetController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let imageCellId = "imageCellId"
    private var items = [(ItemDetail, UIImage)]()

    var didPressSet: ((DailyShopItem) -> Void)?

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: imageCellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath)
        guard let itemCell = cell as? ImageCell else {
            return cell
        }
        let image = items[indexPath.row].1
        itemCell.showImage(image)
        return itemCell
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
        let item = items[indexPath.row].0
        let dailyShopItem = DailyShopItem(identity: item.identity, image: item.fullBackground)
        didPressSet?(dailyShopItem)
    }

    func insert(_ items: [(ItemDetail, UIImage)]) {
        self.items = items
        collectionView.reloadData()
    }
}
