//
//  Item.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

struct Item {
    let item: DailyShopItem
    let profileImage: UIImage

    init(item: DailyShopItem, profileImage: UIImage) {
        self.item = item
        self.profileImage = profileImage
    }
}
