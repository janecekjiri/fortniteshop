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
    private var filters = [FilterModel]()

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeFilters()
        navigationItem.title = "Browse Items"
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
    }

}

// MARK: - UICollectionView Setup Methods
extension BrowseItemsController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let filterCell = cell as? ImageCell else {
            return cell
        }
        let filter = filters[indexPath.item]
        filterCell.showTransparentImage(
            UIImage.returnBrowseItemsOptionImage(for: filter.itemsFilter),
            withBackgroundRarity: filter.returnRarity()
        )
        return filterCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = filters[indexPath.item]
        let filteredItemController = FilteredItemController(filter: filter)
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
    private func makeFilters() {
        filters = [
            FilterModel(filter: .all, title: "All Items"),
            FilterModel(filter: .rarity(.uncommon), title: "Uncommon Items"),
            FilterModel(filter: .rarity(.rare), title: "Rare Items"),
            FilterModel(filter: .rarity(.epic), title: "Epic Items"),
            FilterModel(filter: .rarity(.legendary), title: "Legendary Items"),
            FilterModel(filter: .rarity(.darkSeries), title: "Dark Series Items"),
            FilterModel(filter: .rarity(.frozenSeries), title: "Frozen Series Items"),
            FilterModel(filter: .rarity(.shadowSeries), title: "Shadow Series Items"),
            FilterModel(filter: .rarity(.slurpSeries), title: "Slurp Series Items"),
            FilterModel(filter: .rarity(.lavaSeries), title: "Lava Series Items"),
            FilterModel(filter: .rarity(.iconSeries), title: "Icon Series Items"),
            FilterModel(filter: .rarity(.marvel), title: "Marvel Items"),
            FilterModel(filter: .rarity(.dcSeries), title: "DC Series Items"),
            FilterModel(filter: .rarity(.starWarsSeries), title: "Star Wars Series Items"),
            FilterModel(filter: .rarity(.gamingLegendsSeries), title: "Gaming Legends Series Items"),
            FilterModel(filter: .itemType(.bundle), title: "Bundles"),
            FilterModel(filter: .itemType(.backpack), title: "Backpacks"),
            FilterModel(filter: .itemType(.contrail), title: "Contrails"),
            FilterModel(filter: .itemType(.emoji), title: "Emojis"),
            FilterModel(filter: .itemType(.emote), title: "Emotes"),
            FilterModel(filter: .itemType(.glider), title: "Gliders"),
            FilterModel(filter: .itemType(.loadingScreen), title: "Loading Screens"),
            FilterModel(filter: .itemType(.music), title: "Music"),
            FilterModel(filter: .itemType(.outfit), title: "Outfits"),
            FilterModel(filter: .itemType(.pet), title: "Pet"),
            FilterModel(filter: .itemType(.pickaxe), title: "Pickaxes"),
            FilterModel(filter: .itemType(.spray), title: "Sprays"),
            FilterModel(filter: .itemType(.toy), title: "Toys"),
            FilterModel(filter: .itemType(.wrap), title: "Wraps")
        ]
    }
}
