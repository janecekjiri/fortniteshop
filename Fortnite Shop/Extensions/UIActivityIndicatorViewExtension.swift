//
//  UIActivityIndicatorViewExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 11/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    static func makeLargeWhiteIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .white
        view.hidesWhenStopped = true
        return view
    }
}
