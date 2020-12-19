//
//  UIStackViewExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 19/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIStackView {
    static func makeVerticalStackView(
        arrangedSubview: [UIView],
        distribution: UIStackView.Distribution,
        spacing: CGFloat
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubview)
        stackView.axis = .vertical
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
