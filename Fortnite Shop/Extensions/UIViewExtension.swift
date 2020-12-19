//
//  UIViewExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 19/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIView {
    static func makeView(ofColor color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
