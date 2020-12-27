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

    enum ItemsKeys: String, CodingKey {
        case emoji, glider, backpack, pickaxe, wrap, spray, outfit, music, emote, contrail, bundle, toy, pet
        case cosmeticVariant = "cosmeticvariant"
        case loadingScreen = "loadingscreen"
        case tandemOutfit = "tandemoutfit"
        case itemAccess = "itemaccess"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let itemsContainer = try container.nestedContainer(keyedBy: ItemsKeys.self, forKey: .items)
        let emoji = try itemsContainer.decode([ListItem].self, forKey: .emoji)
        let glider = try itemsContainer.decode([ListItem].self, forKey: .glider)
        let backpack = try itemsContainer.decode([ListItem].self, forKey: .backpack)
        let cosmeticVariant = try itemsContainer.decode([ListItem].self, forKey: .cosmeticVariant)
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
        let tandemOutfit = try itemsContainer.decode([ListItem].self, forKey: .tandemOutfit)
        let itemAccess = try itemsContainer.decode([ListItem].self, forKey: .itemAccess)
        var allItems = emoji + glider + backpack + cosmeticVariant + pickaxe + wrap + spray + outfit + music
        allItems += loadingScreen + emote + contrail
        allItems += bundle + toy + pet + tandemOutfit + itemAccess
        items = allItems
    }
}
