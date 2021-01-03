//
//  FilteredItemController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 03/01/2021.
//  Copyright © 2021 Jiri Janecek. All rights reserved.
//

import UIKit

class FilteredItemController: UICollectionViewController {

    private let cellId = "cellId"
    private let filterOption: BrowseItemsOption
    private var items = [(ListItem, ImageTask)]()

    init(filterOption: BrowseItemsOption) {
        self.filterOption = filterOption
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        fetchData()
    }

}

// MARK: - Custom Methods
extension FilteredItemController {
    private func fetchData() {
        Service.shared.fetchAllItems { allItemsModels in
            guard let allItemsModels = allItemsModels else {
                return
            }
            self.filterItems(allItemsModels.items)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func filterItems(_ items: [ListItem]) {
        var tempItems = items
        switch filterOption {
        case .all:
            break
        case .rarity(let rarity):
            tempItems.removeAll { $0.rarity != rarity }
        case .itemType(let itemType, let rarity):
            tempItems.removeAll { $0.type != itemType }
        }

        let session = URLSession.shared
        tempItems.enumerated().forEach { index, item in
            let imageTask = ImageTask(url: item.fullBackground, session: session)
            imageTask.didDownloadImage = {
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
            self.items.append((item, imageTask))
        }
    }
}

// MARK: - UICollectionView Setup Methods
extension FilteredItemController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let itemCell = cell as? ImageCell else {
            return cell
        }
        let item = items[indexPath.item].0
        let imageTask = items[indexPath.item].1
        itemCell.showFullBackgroundImage(imageTask.image, for: item.rarity)
        return itemCell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        items[indexPath.item].1.resume()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        items[indexPath.item].1.pause()
    }

}

// MARK: - UICollectionView Layout Methods
extension FilteredItemController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 30)/2
        return .init(width: width, height: width)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
