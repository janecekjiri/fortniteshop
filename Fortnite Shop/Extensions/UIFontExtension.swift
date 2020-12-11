//
//  UIFontExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 11/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIFont {
    static func fortniteFont(ofSize fontSize: CGFloat) -> UIFont {
        guard let fortniteFont = UIFont(name: "BurbankBigCondensed-Black", size: fontSize) else {
            return .systemFont(ofSize: fontSize)
        }
        return fortniteFont
    }
}
