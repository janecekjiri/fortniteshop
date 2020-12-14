//
//  DailyShopItem.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 12/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct DailyShopItem: Decodable {
    // TODO: change date-related properties to type Date
    let identity, name, description, type, rarity, image, releaseDate, lastAppearance: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case name, description, type, rarity, releaseDate, lastAppearance, price
        case identity = "id"
        case image = "full_background"
    }
}
