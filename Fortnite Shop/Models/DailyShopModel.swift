//
//  DailyShopModel.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct DailyShopModel: Decodable {
    let items: [DailyShopItem]

    enum CodingKeys: CodingKey {
        case featured, daily, specialFeatured, specialDaily, community, offers
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let featured = try container.decode([DailyShopItem].self, forKey: .featured)
        let daily = try container.decode([DailyShopItem].self, forKey: .daily)
        let specialFeatured = try container.decode([DailyShopItem].self, forKey: .specialFeatured)
        let specialDaily = try container.decode([DailyShopItem].self, forKey: .specialDaily)
        let community = try container.decode([DailyShopItem].self, forKey: .community)
        let offers = try container.decode([DailyShopItem].self, forKey: .offers)
        items = featured + daily + specialFeatured + specialDaily + community + offers
    }
}
