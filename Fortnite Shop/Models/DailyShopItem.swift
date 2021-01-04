//
//  DailyShopItem.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 12/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct DailyShopItem: Decodable, ItemDetailProtocol, Comparable {
    let identity, fullBackground, name: String
    let rarity: Rarity

    enum CodingKeys: String, CodingKey {
        case rarity, name
        case identity = "id"
        case fullBackground = "full_background"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        identity = try container.decode(String.self, forKey: .identity)
        fullBackground = try container.decode(String.self, forKey: .fullBackground)
        let stringRarity = try container.decode(String.self, forKey: .rarity)
        rarity = Rarity(rawValue: stringRarity) ?? Rarity.unknown
    }

    static func<(lhs: DailyShopItem, rhs: DailyShopItem) -> Bool {
        return lhs.rarity < rhs.rarity
    }
}
