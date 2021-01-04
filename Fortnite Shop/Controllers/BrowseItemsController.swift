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
        let filteredItemController = FilteredItemController(filterOption: item)
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
            BrowseItemModel(browseItemsOption: .all, title: "All Items"),
            BrowseItemModel(browseItemsOption: .rarity(.uncommon), title: "Uncommon Items"),
            BrowseItemModel(browseItemsOption: .rarity(.rare), title: "Rare Items"),
            BrowseItemModel(browseItemsOption: .rarity(.epic), title: "Epic Items"),
            BrowseItemModel(browseItemsOption: .rarity(.legendary), title: "Legendary Items"),
            BrowseItemModel(browseItemsOption: .rarity(.darkSeries), title: "Dark Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.frozenSeries), title: "Frozen Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.shadowSeries), title: "Shadow Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.slurpSeries), title: "Slurp Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.lavaSeries), title: "Lava Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.iconSeries), title: "Icon Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.marvel), title: "Marvel Items"),
            BrowseItemModel(browseItemsOption: .rarity(.dcSeries), title: "DC Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.starWarsSeries), title: "Star Wars Series Items"),
            BrowseItemModel(browseItemsOption: .rarity(.gamingLegendsSeries), title: "Gaming Legends Series Items"),
            BrowseItemModel(browseItemsOption: .itemType(.bundle, .legendary), title: "Bundles"),
            BrowseItemModel(browseItemsOption: .itemType(.backpack, .uncommon), title: "Backpacks"),
            BrowseItemModel(browseItemsOption: .itemType(.contrail, .uncommon), title: "Contrails"),
            BrowseItemModel(browseItemsOption: .itemType(.emoji, .uncommon), title: "Emojis"),
            BrowseItemModel(browseItemsOption: .itemType(.emote, .uncommon), title: "Emotes"),
            BrowseItemModel(browseItemsOption: .itemType(.glider, .uncommon), title: "Gliders"),
            BrowseItemModel(browseItemsOption: .itemType(.loadingScreen, .uncommon), title: "Loading Screens"),
            BrowseItemModel(browseItemsOption: .itemType(.music, .uncommon), title: "Music"),
            BrowseItemModel(browseItemsOption: .itemType(.outfit, .uncommon), title: "Outfits"),
            BrowseItemModel(browseItemsOption: .itemType(.pet, .uncommon), title: "Pet"),
            BrowseItemModel(browseItemsOption: .itemType(.pickaxe, .uncommon), title: "Pickaxes"),
            BrowseItemModel(browseItemsOption: .itemType(.spray, .uncommon), title: "Sprays"),
            BrowseItemModel(browseItemsOption: .itemType(.toy, .uncommon), title: "Toys"),
            BrowseItemModel(browseItemsOption: .itemType(.wrap, .uncommon), title: "Wraps")
        ]
    }
}
