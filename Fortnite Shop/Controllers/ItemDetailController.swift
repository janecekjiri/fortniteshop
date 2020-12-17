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
    var images = [UIImage]()

    let datesController = DatesController()
    let imagesController = ImagesController()
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
        view.backgroundColor = .black
        thirdVC.view.backgroundColor = .green // TODO: Remove
        addChildControllers()
        setUpActivityIndicator()
        fetchItemDetail()
    }

    private func fetchItemDetail() {
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
                    self.images.append(image)
                    self.fetchImages(for: itemDetail)
                }
            }
        }
    }

    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    // TODO: Move to DatesController
    private func fetchImages(for item: ItemDetail) {
        let urls = makeLinkArray(for: item)
        let dispatchGroup = DispatchGroup()
        urls.forEach { url in
            dispatchGroup.enter()
            Service.shared.fetchImage(url: url) { image in
                dispatchGroup.leave()
                guard let image = image else {
                    return
                }
                self.images.append(image)
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.imagesController.appendImages(self.images)
        }
    }

    // TODO: Move to DatesController
    private func makeLinkArray(for item: ItemDetail) -> [String] {
        var urls = [item.icon, item.background]
        [item.featured, item.fullSize].forEach { url in
            if let url = url {
                urls.append(url)
            }
        }
        return urls
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

    private func addChildControllers() {
        addChild(controller: datesController, doesHaveBorder: true)
        addChild(controller: imagesController)
    }

}
