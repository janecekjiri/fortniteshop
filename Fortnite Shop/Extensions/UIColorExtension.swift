//
//  UIColorExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIColor {

    // MARK: - Custom Methods
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }

    static func rarityColor(for rarity: Rarity) -> UIColor {
        switch rarity {
        case .uncommon:
            return uncommonRarityColor
        case .rare:
            return rareRarityColor
        case .epic:
            return epicRarityColor
        case .legendary:
            return legendaryRarityColor
        default:
            return commonRarityColor
        }
    }

    static func rarityBorderColor(for rarity: Rarity) -> UIColor {
        switch rarity {
        case .uncommon:
            return uncommonBorderColor
        case .rare:
            return rareBorderColor
        case .epic:
            return epicBorderColor
        case .legendary:
            return legendaryBorderColor
        case .darkSeries:
            return darkSeriesBorderColor
        case .frozenSeries:
            return frozenSeriesBorderColor
        case .shadowSeries:
            return shadowSeriesBorderColor
        case .slurpSeries:
            return slurpSeriesBorderColor
        case .lavaSeries:
            return lavaSeriesBorderColor
        case .iconSeries:
            return iconSeriesBorderColor
        case .marvel:
            return marvelBorderColor
        case .dcSeries:
            return dcSeriesBorderColor
        case .starWarsSeries:
            return starWarsSeriesBorderColor
        case .gamingLegendsSeries:
            return gamingLegendsSeriesBorderColor
        default:
            return commonBorderColor
        }
    }

    // MARK: - Rarity Colors
    static let commonRarityColor = UIColor.gray

    static let uncommonRarityColor = UIColor(red: 49, green: 146, blue: 54)

    static let rareRarityColor = UIColor(red: 11, green: 118, blue: 170)

    static let epicRarityColor = UIColor(red: 157, green: 77, blue: 187)

    static let legendaryRarityColor = UIColor(red: 195, green: 94, blue: 40)

    // MARK: - Rarity Border Colors

    static let commonBorderColor = UIColor(red: 177, green: 177, blue: 177)

    static let uncommonBorderColor = UIColor(red: 135, green: 227, blue: 57)

    static let rareBorderColor = UIColor(red: 55, green: 209, blue: 255)

    static let epicBorderColor = UIColor(red: 233, green: 94, blue: 255)

    static let legendaryBorderColor = UIColor(red: 233, green: 141, blue: 75)

    static let darkSeriesBorderColor = UIColor(red: 255, green: 66, blue: 231)

    static let frozenSeriesBorderColor = UIColor(red: 170, green: 208, blue: 238)

    static let shadowSeriesBorderColor = UIColor(red: 110, green: 110, blue: 110)

    static let slurpSeriesBorderColor = UIColor(red: 0, green: 139, blue: 222)

    static let lavaSeriesBorderColor = UIColor(red: 160, green: 48, blue: 53)

    static let iconSeriesBorderColor = UIColor(red: 64, green: 184, blue: 199)

    static let marvelBorderColor = UIColor(red: 239, green: 53, blue: 55)

    static let dcSeriesBorderColor = UIColor(red: 96, green: 148, blue: 206)

    static let starWarsSeriesBorderColor = UIColor(red: 76, green: 76, blue: 76)

    static let gamingLegendsSeriesBorderColor = UIColor(red: 127, green: 120, blue: 249)

    // MARK: - ItemDetailController Colors
    static let dateControllerBorder = UIColor(red: 103, green: 103, blue: 103)

    static let dateControllerCellDarkGray = UIColor(red: 52, green: 52, blue: 52)

    static let dateControllerCellLightGray = UIColor(red: 62, green: 62, blue: 62)

    static let segmentControlYellow = UIColor(red: 237, green: 237, blue: 120)

    static let segmentControlGray = UIColor(red: 54, green: 54, blue: 57)
}
