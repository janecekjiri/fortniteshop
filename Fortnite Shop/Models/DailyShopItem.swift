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
    private(set) var lastAppearance: String?

    enum CodingKeys: String, CodingKey {
        case rarity, name, lastAppearance
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

        let lastAppearanceString = try container.decode(String?.self, forKey: .lastAppearance)
        lastAppearance = nil
        lastAppearance = setLastAppearance(for: lastAppearanceString)
    }

    static func<(lhs: DailyShopItem, rhs: DailyShopItem) -> Bool {
        return lhs.rarity < rhs.rarity
    }
}

// MARK: - Methods for getting last appearance
extension DailyShopItem {

    private func setLastAppearance(for date: String?) -> String? {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let lastAppearanceDate = dateFormatter.date(from: date) {
                let daysAgo = calculateDaysAgo(for: lastAppearanceDate)
                return returnLastAppearance(for: daysAgo)
            }
        }
        return nil
    }

    private func calculateDaysAgo(for date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
    }

    private func returnLastAppearance(for daysAgo: Int) -> String? {
        switch daysAgo {
        case 0:
            return "NEW!"
        case 1...99:
            return nil
        case 100...364:
            return "BACK AFTER \(daysAgo) DAYS!"
        case 365...729:
            return "BACK AFTER 1 YEAR!"
        default:
            return "BACK AFTER \(daysAgo/365) YEARS!"
        }
    }

}
