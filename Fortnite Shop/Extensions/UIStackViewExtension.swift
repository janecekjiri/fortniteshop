//
//  UIStackViewExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 19/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIStackView {
    fileprivate static func makeGenericStackView(
        arrangedSubview: [UIView],
        distribution: UIStackView.Distribution,
        spacing: CGFloat,
        axis: NSLayoutConstraint.Axis
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubview)
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    static func makeVerticalStackView(
        arrangedSubview: [UIView],
        distribution: UIStackView.Distribution,
        spacing: CGFloat = 0.0
    ) -> UIStackView {
        return makeGenericStackView(
            arrangedSubview: arrangedSubview,
            distribution: distribution,
            spacing: spacing,
            axis: .vertical
        )
    }

    static func makeHorizontalStackView(
        arrangedSubview: [UIView],
        distribution: UIStackView.Distribution,
        spacing: CGFloat = 0.0
    ) -> UIStackView {
        return makeGenericStackView(
            arrangedSubview: arrangedSubview,
            distribution: distribution,
            spacing: spacing,
            axis: .horizontal
        )
    }
}
