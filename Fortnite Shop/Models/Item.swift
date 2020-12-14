//
//  Item.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

struct Item {
    let identity, name, description, type, rarity, releaseDate, lastAppearance: String
    let price: Int
    let profileImage: UIImage

    init(item: DailyShopItem, profileImage: UIImage) {
        identity = item.identity
        name = item.name
        description = item.description
        type = item.type
        rarity = item.rarity
        releaseDate = item.releaseDate
        lastAppearance = item.lastAppearance
        price = item.price
        self.profileImage = profileImage
    }
}
