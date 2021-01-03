//
//  BrowseItemModel.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 03/01/2021.
//  Copyright © 2021 Jiri Janecek. All rights reserved.
//

import Foundation

enum BrowseItemsOption {
    case all
    case rarity(Rarity)
    case itemType(ItemType, Rarity)
}

class BrowseItemModel {
    let browseItemsOption: BrowseItemsOption

    init(browseItemsOption: BrowseItemsOption) {
        self.browseItemsOption = browseItemsOption
    }

    func returnRarity() -> Rarity {
        switch browseItemsOption {
        case .all:
            return Rarity.common
        case .rarity(let rarity):
            return rarity
        case .itemType(let itemType, let rarity):
            return rarity
        }
    }
}
