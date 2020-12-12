//
//  Item.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 12/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let image: String

    enum CodingKeys: String, CodingKey {
        case image = "full_background"
    }
}
