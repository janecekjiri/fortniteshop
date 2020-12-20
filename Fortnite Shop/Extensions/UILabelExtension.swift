//
//  UILabelExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 15/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

private enum FontType {
    case system
    case bold
}

extension UILabel {

    // MARK: - Methods Returning Specific Labels
    private static func makeGenericLabel(
        ofSize size: CGFloat,
        with text: String? = nil,
        fontType: FontType
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        if fontType == .system {
            label.font = .systemFont(ofSize: size)
        } else {
            label.font = .boldSystemFont(ofSize: size)
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeBoldLabel(ofSize size: CGFloat, with text: String? = nil) -> UILabel {
        return makeGenericLabel(ofSize: size, with: text, fontType: .bold)
    }

    static func makeSystemLabel(ofSize size: CGFloat, with text: String? = nil) -> UILabel {
        return makeGenericLabel(ofSize: size, with: text, fontType: .system)
    }

    static func makeCenteredLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
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
