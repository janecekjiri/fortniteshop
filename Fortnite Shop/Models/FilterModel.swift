//
//  FilterModel.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 03/01/2021.
//  Copyright © 2021 Jiri Janecek. All rights reserved.
//

import Foundation

enum ItemsFilter {
    case all
    case rarity(Rarity)
    case itemType(ItemType)
}

class FilterModel {
    let filter: ItemsFilter
    let title: String

    init(filter: ItemsFilter, title: String) {
        self.filter = filter
        self.title = title
    }

    func returnRarity() -> Rarity {
        switch filter {
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
