//
//  ItemDetail.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct ItemDetail: Decodable {
    let name: String
    let type: String
    let rarity: String
    let price: Int
    let releaseDate: String
    let lastAppearance: String
    let description: String
    let set: String
    let itemsInSet: [String]
    let history: [String]
    let icon: String
    let fullSize: String
    let featured: String
    let background: String
    let fullBackground: String

    enum CodingKeys: String, CodingKey {
        case name, type, rarity, price, releaseDate, lastAppearance, description, set, itemsInSet, images
        case history = "shopHistory"
    }

    enum ImageKeys: String, CodingKey {
        case icon, featured, background
        case fullSize = "full_size"
        case fullBackground = "full_background"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        rarity = try container.decode(String.self, forKey: .rarity)
        price = try container.decode(Int.self, forKey: .price)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        lastAppearance = try container.decode(String.self, forKey: .lastAppearance)
        description = try container.decode(String.self, forKey: .description)
        set = try container.decode(String.self, forKey: .set)
        itemsInSet = try container.decode([String].self, forKey: .itemsInSet)
        history = try container.decode([String].self, forKey: .history)
        let imagesContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .images)
        icon = try imagesContainer.decode(String.self, forKey: .icon)
        fullSize = try imagesContainer.decode(String.self, forKey: .fullSize)
        featured = try imagesContainer.decode(String.self, forKey: .featured)
        background = try imagesContainer.decode(String.self, forKey: .background)
        fullBackground = try imagesContainer.decode(String.self, forKey: .fullBackground)
    }

}
