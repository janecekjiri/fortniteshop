//
//  ItemDetailController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {

    let item: Item

    let itemDetailView = ItemDetailView()

    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        print(item.name)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(itemDetailView)
        itemDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        itemDetailView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemDetailView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
