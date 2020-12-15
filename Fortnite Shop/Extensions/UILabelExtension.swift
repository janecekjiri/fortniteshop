//
//  UILabelExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 15/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UILabel {
    static func makeHistoryLabel(withBoldText boldText: String, withNormalText normalText: String) -> UILabel {
        let label = UILabel()
        let boldPart = NSAttributedString(
            string: boldText,
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        )
        let normalPart = NSAttributedString(
            string: normalText,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        )
        let mutableString = NSMutableAttributedString()
        mutableString.append(boldPart)
        mutableString.append(normalPart)
        label.attributedText = mutableString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
