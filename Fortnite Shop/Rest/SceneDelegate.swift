//
//  SceneDelegate.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 09/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let dailyShopController = DailyShopController()
            let searchController = SearchItemsController()
            let tabBarController = BaseTabBarController()
            tabBarController.addController(dailyShopController, with: "Item Shop", with: "shoppingCart")
            tabBarController.addController(searchController, with: "Search", with: "search")

            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            self.window = window
        }
    }

}
