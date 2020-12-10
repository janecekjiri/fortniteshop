//
//  DailyShopModel.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct DailyShopModel: Decodable {
    let featured: [Item]
    let daily: [Item]
    let specialFeatured: [Item]
    let specialDaily: [Item]
    let community: [Item]
    let offers: [Item]
}

struct Item: Decodable {
    let image: String

    enum CodingKeys: String, CodingKey {
        case image = "full_background"
    }
}
