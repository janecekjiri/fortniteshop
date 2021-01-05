//
//  UIAlertControllerExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func makeErrorAlertController(
        message: String,
        completion: ((UIAlertAction) -> Void)? = nil
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Oops! There was an error...",
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(action)
        return alertController
    }
}
