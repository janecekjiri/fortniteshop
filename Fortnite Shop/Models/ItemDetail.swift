//
//  ItemDetail.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

enum Rarity: String, Comparable {
    case common
    case uncommon
    case rare
    case epic
    case legendary
    case unknown

    static func<(lhs: Rarity, rhs: Rarity) -> Bool {
        return lhs.returnRarityValue() < rhs.returnRarityValue()
    }

    private func returnRarityValue() -> Int {
        switch self {
        case .common:
            return 0
        case .uncommon:
            return 1
        case .rare:
            return 2
        case .epic:
            return 3
        case .legendary:
            return 4
        default:
            return 5
        }
    }
}

struct ItemDetail: Decodable, ItemDetailProtocol {
    let identity, name, description, type, set: String
    let rarity: Rarity
    let price: Int
    let releaseDate, lastAppearance: Date
    let history: [Date]
    let itemsInSet: [String]
    let icon, background, fullBackground: String
    let featured, fullSize: String?

    enum CodingKeys: CodingKey {
        case item
    }

    enum ItemKeys: String, CodingKey {
        case name, type, rarity, price, releaseDate, lastAppearance, description, set, itemsInSet, images
        case identity = "id"
        case history = "shopHistory"
    }

    enum ImageKeys: String, CodingKey {
        case icon, featured, background
        case fullSize = "full_size"
        case fullBackground = "full_background"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let itemContainer = try container.nestedContainer(keyedBy: ItemKeys.self, forKey: .item)
        identity = try itemContainer.decode(String.self, forKey: .identity)
        name = try itemContainer.decode(String.self, forKey: .name)
        type = try itemContainer.decode(String.self, forKey: .type)
        let rarityString = try itemContainer.decode(String.self, forKey: .rarity)
        rarity = Rarity(rawValue: rarityString) ?? .unknown
        price = try itemContainer.decode(Int.self, forKey: .price)
        description = try itemContainer.decode(String.self, forKey: .description)
        set = try itemContainer.decode(String.self, forKey: .set)
        itemsInSet = try itemContainer.decode([String].self, forKey: .itemsInSet)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let releaseDateString = try itemContainer.decode(String.self, forKey: .releaseDate)
        let lastAppearanceString = try itemContainer.decode(String.self, forKey: .lastAppearance)
        let historyStrings = try itemContainer.decode([String].self, forKey: .history)
        releaseDate = dateFormatter.date(from: releaseDateString) ?? Date()
        lastAppearance = dateFormatter.date(from: lastAppearanceString) ?? Date()
        var historyDate = [Date]()
        historyStrings.forEach { historyDate.append(dateFormatter.date(from: $0) ?? Date()) }
        history = historyDate

        let imagesContainer = try itemContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .images)
        icon = try imagesContainer.decode(String.self, forKey: .icon)
        fullSize = try? imagesContainer.decode(String.self, forKey: .fullSize)
        featured = try? imagesContainer.decode(String.self, forKey: .featured)
        background = try imagesContainer.decode(String.self, forKey: .background)
        fullBackground = try imagesContainer.decode(String.self, forKey: .fullBackground)
    }

}
