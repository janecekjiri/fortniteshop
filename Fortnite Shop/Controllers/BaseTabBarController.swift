//
//  BaseTabBarController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 21/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addController(_ controller: UIViewController, with title: String, with imageName: String) {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        guard var currentControllers = viewControllers else {
            viewControllers = [navController]
            return
        }
        currentControllers.append(navController)
        viewControllers = currentControllers
    }

}
