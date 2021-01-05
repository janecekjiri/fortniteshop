//
//  ListItemsModel.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 25/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct ListItemsModel: Decodable {
    let items: [ListItem]

    enum CodingKeys: CodingKey {
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let itemsContainer = try container.nestedContainer(keyedBy: ItemType.self, forKey: .items)
        let emoji = try itemsContainer.decode([ListItem].self, forKey: .emoji)
        let glider = try itemsContainer.decode([ListItem].self, forKey: .glider)
        let backpack = try itemsContainer.decode([ListItem].self, forKey: .backpack)
        let pickaxe = try itemsContainer.decode([ListItem].self, forKey: .pickaxe)
        let wrap = try itemsContainer.decode([ListItem].self, forKey: .wrap)
        let spray = try itemsContainer.decode([ListItem].self, forKey: .spray)
        let outfit = try itemsContainer.decode([ListItem].self, forKey: .outfit)
        let music = try itemsContainer.decode([ListItem].self, forKey: .music)
        let loadingScreen = try itemsContainer.decode([ListItem].self, forKey: .loadingScreen)
        let emote = try itemsContainer.decode([ListItem].self, forKey: .emote)
        let contrail = try itemsContainer.decode([ListItem].self, forKey: .contrail)
        let bundle = try itemsContainer.decode([ListItem].self, forKey: .bundle)
        let toy = try itemsContainer.decode([ListItem].self, forKey: .toy)
        let pet = try itemsContainer.decode([ListItem].self, forKey: .pet)
        var allItems = emoji + glider + backpack + pickaxe + wrap + spray + outfit + music
        allItems += loadingScreen + emote + contrail
        allItems += bundle + toy + pet
        allItems.sort { item1, item2 -> Bool in
            if item1.rarity == item2.rarity {
                return item1.name < item2.name
            }
            return item1 > item2
        }
        items = allItems
    }
}
