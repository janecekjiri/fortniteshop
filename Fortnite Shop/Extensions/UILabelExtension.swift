//
//  UILabelExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 15/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UILabel {

    // MARK: - Methods Returning Specific Labels
    static func makeCenteredLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeBoldLabel(ofSize size: CGFloat, with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeSystemLabel(ofSize size: CGFloat, with text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    // MARK: - Custom Methods
    func setAttributedHistoryText(withBoldText boldText: String, withNormalText normalText: String) {
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
        self.attributedText = mutableString
    }

}
