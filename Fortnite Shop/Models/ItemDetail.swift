//
//  ItemDetail.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct ItemDetail: Decodable {
    let set: String
    let itemsInSet: [String]
    let history: [String]
    let icon: String
    let fullSize: String
    let featured: String
    let background: String
    let fullBackground: String

    enum CodingKeys: String, CodingKey {
        case set, itemsInSet, images
        case history = "shopHistory"
    }

    enum ImageKeys: String, CodingKey {
        case icon, featured, background
        case fullSize = "full_size"
        case fullBackground = "full_background"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
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
