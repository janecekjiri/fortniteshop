//
//  BrowseItemsController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 02/01/2021.
//  Copyright © 2021 Jiri Janecek. All rights reserved.
//

import UIKit

class BrowseItemsController: UICollectionViewController {

    private let cellId = "cellId"
    private var browseItemsOptions = [BrowseItemModel]()

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBrowsingOptions()
        navigationItem.title = "Browse Items"
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
    }

}

// MARK: - UICollectionView Setup Methods
extension BrowseItemsController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return browseItemsOptions.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let filterCell = cell as? ImageCell else {
            return cell
        }
        let option = browseItemsOptions[indexPath.item]
        filterCell.showTransparentImage(
            UIImage.returnBrowseItemsOptionImage(for: option.browseItemsOption),
            withBackgroundRarity: option.returnRarity()
        )
        return filterCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = browseItemsOptions[indexPath.item]
        let filteredItemController = FilteredItemController(filterOption: item.browseItemsOption)
        navigationController?.pushViewController(filteredItemController, animated: true)
    }

}

// MARK: - UICollectionView Layout Methods
extension BrowseItemsController: UICollectionViewDelegateFlowLayout {
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

extension BrowseItemsController {
    private func makeBrowsingOptions() {
        browseItemsOptions = [
            BrowseItemModel(browseItemsOption: .all),
            BrowseItemModel(browseItemsOption: .rarity(.uncommon)),
            BrowseItemModel(browseItemsOption: .rarity(.rare)),
            BrowseItemModel(browseItemsOption: .rarity(.epic)),
            BrowseItemModel(browseItemsOption: .rarity(.legendary)),
            BrowseItemModel(browseItemsOption: .rarity(.darkSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.frozenSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.shadowSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.slurpSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.lavaSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.iconSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.marvel)),
            BrowseItemModel(browseItemsOption: .rarity(.dcSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.starWarsSeries)),
            BrowseItemModel(browseItemsOption: .rarity(.gamingLegendsSeries)),
            BrowseItemModel(browseItemsOption: .itemType(.emoji, .uncommon)),
            BrowseItemModel(browseItemsOption: .itemType(.glider, .marvel)),
            BrowseItemModel(browseItemsOption: .itemType(.backpack, .marvel)),
            BrowseItemModel(browseItemsOption: .itemType(.pickaxe, .epic)),
            BrowseItemModel(browseItemsOption: .itemType(.wrap, .uncommon)),
            BrowseItemModel(browseItemsOption: .itemType(.spray, .uncommon)),
            BrowseItemModel(browseItemsOption: .itemType(.outfit, .uncommon)),
            BrowseItemModel(browseItemsOption: .itemType(.music, .rare)),
            BrowseItemModel(browseItemsOption: .itemType(.emote, .rare)),
            BrowseItemModel(browseItemsOption: .itemType(.contrail, .uncommon)),
            BrowseItemModel(browseItemsOption: .itemType(.bundle, .legendary)),
            BrowseItemModel(browseItemsOption: .itemType(.toy, .rare)),
            BrowseItemModel(browseItemsOption: .itemType(.pet, .epic)),
            BrowseItemModel(browseItemsOption: .itemType(.loadingScreen, .uncommon))
        ]
    }
}
