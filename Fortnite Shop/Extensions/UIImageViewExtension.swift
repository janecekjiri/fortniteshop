//
//  UIImageViewExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 19/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(contentMode: UIImageView.ContentMode) {
        self.init()
        self.contentMode = contentMode
        translatesAutoresizingMaskIntoConstraints = false
    }
}
