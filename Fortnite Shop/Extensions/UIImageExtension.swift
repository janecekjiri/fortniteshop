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

    private static func returnBrowseItemsOptionImage(for rarity: Rarity) -> UIImage? {
        switch rarity {
        case .uncommon:
            return UIImage(named: "uncommonOption")
        case .rare:
            return UIImage(named: "rareOption")
        case .epic:
            return UIImage(named: "epicOption")
        case .legendary:
            return UIImage(named: "legendaryOption")
        case .darkSeries:
            return UIImage(named: "darkSeriesOption")
        case .dcSeries:
            return UIImage(named: "dcSeriesOption")
        case .frozenSeries:
            return UIImage(named: "frozenSeriesOption")
        case .gamingLegendsSeries:
            return UIImage(named: "gamingLegendsSeriesOption")
        case .iconSeries:
            return UIImage(named: "iconSeriesOption")
        case .lavaSeries:
            return UIImage(named: "lavaSeriesOption")
        case .marvel:
            return UIImage(named: "marvelOption")
        case .shadowSeries:
            return UIImage(named: "shadowSeriesOption")
        case .slurpSeries:
            return UIImage(named: "slurpSeriesOption")
        case .starWarsSeries:
            return UIImage(named: "starWarsSeriesOption")
        default:
            return nil
        }
    }

    private static func returnBrowseItemsOptionImage(for itemType: ItemType) -> UIImage? {
        switch itemType {
        case .backpack:
            return UIImage(named: "backpacksOption")
        case .bundle:
            return UIImage(named: "bundlesOption")
        case .contrail:
            return UIImage(named: "contrailsOption")
        case .emoji:
            return UIImage(named: "emojisOption")
        case .emote:
            return UIImage(named: "emotesOption")
        case .glider:
            return UIImage(named: "glidersOption")
        case .loadingScreen:
            return UIImage(named: "loadingScreensOption")
        case .music:
            return UIImage(named: "musicOption")
        case .outfit:
            return UIImage(named: "outfitsOption")
        case .pet:
            return UIImage(named: "petsOption")
        case .pickaxe:
            return UIImage(named: "pickaxesOption")
        case .spray:
            return UIImage(named: "spraysOption")
        case .toy:
            return UIImage(named: "toysOption")
        case .wrap:
            return UIImage(named: "wrapsOption")
        default:
            return nil
        }
    }

    static func returnBrowseItemsOptionImage(for option: ItemsFilter) -> UIImage? {
        switch option {
        case .all:
            return UIImage(named: "allItemsOption")
        case .rarity(let rarity):
            return returnBrowseItemsOptionImage(for: rarity)
        case .itemType(let itemType):
            return returnBrowseItemsOptionImage(for: itemType)
        }
    }
}
