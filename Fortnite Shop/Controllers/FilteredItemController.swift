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
    }

}

// MARK: - UICollectionView Setup Methods
extension FilteredItemController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let itemCell = cell as? ImageCell else {
            return cell
        }
        itemCell.backgroundColor = .red
        return itemCell
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
