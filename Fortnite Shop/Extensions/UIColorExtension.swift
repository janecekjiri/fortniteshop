//
//  UIColorExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }

    static let dateControllerBorder = UIColor(red: 103, green: 103, blue: 103)

    static let dateControllerCellDarkGray = UIColor(red: 52, green: 52, blue: 52)

    static let dateControllerCellLightGray = UIColor(red: 62, green: 62, blue: 62)

    static let segmentControlYellow = UIColor(red: 237, green: 237, blue: 120)

    static let segmentControlGray = UIColor(red: 54, green: 54, blue: 57)
}
