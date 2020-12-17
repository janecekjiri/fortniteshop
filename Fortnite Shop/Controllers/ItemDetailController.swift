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

    let datesController = DatesController()
    let secondVC = UIViewController()
    let thirdVC = UIViewController()

    init(for item: DailyShopItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        secondVC.view.backgroundColor = .blue // TODO: Remove
        thirdVC.view.backgroundColor = .green // TODO: Remove
        addChild(controller: datesController, doesHaveBorder: true)
        addChild(controller: secondVC)
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        Service.shared.fetchItemDetail(for: item) { itemDetail in
            guard let itemDetail = itemDetail else {
                return
            }
            self.datesController.addDates(itemDetail.history)
            if !itemDetail.itemsInSet.isEmpty {
                DispatchQueue.main.async {
                    self.addChild(controller: self.thirdVC)
                }
            }
            Service.shared.fetchImage(url: itemDetail.fullBackground) { image in
                guard let image = image else {
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.navigationItem.title = itemDetail.name
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

    private func addChild(controller: UIViewController, doesHaveBorder: Bool = false) {
        addChild(controller)
        itemDetailView.addChild(view: controller.view, doesHaveBorder: doesHaveBorder)
        controller.didMove(toParent: self)
    }

}
