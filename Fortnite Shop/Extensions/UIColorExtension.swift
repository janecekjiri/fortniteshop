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

    // MARK: - Rarity Colors
    static let commonRarityColor = UIColor.gray

    static let uncommonRarityColor = UIColor(red: 49, green: 146, blue: 54)

    static let rareRarityColor = UIColor(red: 11, green: 118, blue: 170)

    static let epicRarityColor = UIColor(red: 157, green: 77, blue: 187)

    static let legendaryRarityColor = UIColor(red: 195, green: 94, blue: 40)

    // MARK: - ItemDetailController Colors
    static let dateControllerBorder = UIColor(red: 103, green: 103, blue: 103)

    static let dateControllerCellDarkGray = UIColor(red: 52, green: 52, blue: 52)

    static let dateControllerCellLightGray = UIColor(red: 62, green: 62, blue: 62)

    static let segmentControlYellow = UIColor(red: 237, green: 237, blue: 120)

    static let segmentControlGray = UIColor(red: 54, green: 54, blue: 57)
}
