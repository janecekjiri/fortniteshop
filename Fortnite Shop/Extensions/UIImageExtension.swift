//
//  UIImageExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 31/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIImage {
    static func rarityBackground(for rarity: Rarity) -> UIImage? {
        switch rarity {
        case .uncommon:
            return UIImage(named: "uncommon")
        case .rare:
            return UIImage(named: "rare")
        case .epic:
            return UIImage(named: "epic")
        case .legendary:
            return UIImage(named: "legendary")
        case .darkSeries:
            return UIImage(named: "darkSeries")
        case .frozenSeries:
            return UIImage(named: "frozenSeries")
        case .shadowSeries:
            return UIImage(named: "shadowSeries")
        case .slurpSeries:
            return UIImage(named: "slurpSeries")
        case .lavaSeries:
            return UIImage(named: "lavaSeries")
        case .iconSeries:
            return UIImage(named: "iconSeries")
        case .marvel:
            return UIImage(named: "marvel")
        case .dcSeries:
            return UIImage(named: "dcSeries")
        case .starWarsSeries:
            return UIImage(named: "starWarsSeries")
        case .gamingLegendsSeries:
            return UIImage(named: "gamingLegendsSeries")
        default:
            return UIImage(named: "common")
        }
    }
}
