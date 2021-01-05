//
//  ListItem.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 25/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct ListItem: Decodable, Comparable, ItemDetailProtocol {
    let name, identity, fullBackground: String
    let rarity: Rarity
    let type: ItemType

    enum CodingKeys: String, CodingKey {
        case name, images, rarity, type
        case identity = "id"
    }

    enum ImageKeys: String, CodingKey {
        case image = "full_background"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        identity = try container.decode(String.self, forKey: .identity)
        let rarityString = try container.decode(String.self, forKey: .rarity)
        rarity = Rarity(rawValue: rarityString) ?? .unknown
        let stringType = try container.decode(String.self, forKey: .type)
        type = ItemType(stringValue: stringType) ?? ItemType.unknown
        let imagesContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .images)
        fullBackground = try imagesContainer.decode(String.self, forKey: .image)
    }

    static func<(lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.rarity < rhs.rarity
    }
}
