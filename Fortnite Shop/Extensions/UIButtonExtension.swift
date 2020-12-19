//
//  UIButtonExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 19/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIButton {
    static func makeBorderlessBoldButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setAttributedTitle(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 16),
                    .foregroundColor: UIColor.white
                ]
            ),
            for: .normal
        )
        button.layer.borderWidth = 0.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
