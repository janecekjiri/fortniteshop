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
        tabBar.barStyle = .black
    }

    func addController(_ controller: UIViewController, with title: String, with imageName: String) {
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.barStyle = .black
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(named: imageName),
            selectedImage: UIImage(named: imageName)?.withTintColor(
                .segmentControlYellow,
                renderingMode: .alwaysOriginal
            )
        )
        tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.segmentControlYellow],
            for: .selected
        )
        navController.tabBarItem = tabBarItem
        guard var currentControllers = viewControllers else {
            viewControllers = [navController]
            return
        }
        currentControllers.append(navController)
        viewControllers = currentControllers
    }

}
