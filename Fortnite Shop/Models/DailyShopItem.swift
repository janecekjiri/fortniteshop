//
//  DailyShopItem.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 12/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct DailyShopItem: Decodable, ItemDetailProtocol {
    let identity, fullBackground: String

    enum CodingKeys: String, CodingKey {
        case identity = "id"
        case fullBackground = "full_background"
    }
}
