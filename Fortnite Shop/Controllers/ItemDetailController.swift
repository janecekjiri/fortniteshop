//
//  ItemDetailController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {

    let item: DailyShopItem

    let itemDetailView = ItemDetailView()
    let activityIndicator = UIActivityIndicatorView.largeWhiteIndicator

    init(for item: DailyShopItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        Service.shared.fetchItemDetail(for: item) { itemDetail in
            guard let itemDetail = itemDetail else {
                return
            }
            Service.shared.fetchImage(url: itemDetail.fullBackground) { image in
                guard let image = image else {
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.setUpDetailView(for: itemDetail, with: image)
                }
            }
        }
    }

    private func setUpDetailView(for item: ItemDetail, with image: UIImage) {
        view.addSubview(itemDetailView)
        itemDetailView.setUpView(for: item, with: image)
        itemDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        itemDetailView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemDetailView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
