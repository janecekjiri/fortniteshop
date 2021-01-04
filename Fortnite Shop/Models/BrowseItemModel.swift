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
    case itemType(ItemType)
}

class BrowseItemModel {
    let browseItemsOption: BrowseItemsOption
    let title: String

    init(browseItemsOption: BrowseItemsOption, title: String) {
        self.browseItemsOption = browseItemsOption
        self.title = title
    }

    func returnRarity() -> Rarity {
        switch browseItemsOption {
        case .all:
            return Rarity.common
        case .rarity(let rarity):
            return rarity
        case .itemType(let itemType):
            if itemType == .bundle {
                return .legendary
            } else {
                return .uncommon
            }
        }
    }
}
