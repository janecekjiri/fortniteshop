//
//  ItemDetailController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {

    let itemDetailView = ItemDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(itemDetailView)
        itemDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        itemDetailView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemDetailView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
