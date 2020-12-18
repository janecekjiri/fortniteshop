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
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?

    let itemDetailView = ItemDetailView()
    let imageDetailView = ImageDetailView()
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
        setUpImagesController()
        thirdVC.view.backgroundColor = .green // TODO: Remove
        addChildControllers()
        setUpActivityIndicator()
        setUpImageDetailView()
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
            DispatchQueue.main.async {
                self.imageDetailView.backgroundColor = UIColor.rarityColor(for: itemDetail.rarity)
            }
            Service.shared.fetchImage(url: itemDetail.fullBackground) { image in
                guard let image = image else {
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.navigationItem.title = itemDetail.name
                    self.setUpDetailView(for: itemDetail, with: image)
                    self.fetchImages(for: itemDetail)
                    self.positionImageDetailView()
                }
            }
        }
    }

    private func setUpImageDetailView() {
        imageDetailView.didPressCloseButton = {
            self.topConstraint?.constant = self.view.bounds.height
            self.bottomConstraint?.constant = self.view.bounds.height
            self.navigationController?.navigationBar.isHidden = false
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.view.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }

    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    private func fetchImages(for item: ItemDetail) {
        let urls = makeLinkArray(for: item)
        let dispatchGroup = DispatchGroup()
        urls.forEach { url in
            dispatchGroup.enter()
            Service.shared.fetchImage(url: url) { image in
                guard let image = image else {
                    return
                }
                self.images.append(image)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            //self.imagesController.appendImages(self.images)
            self.imagesController.insert(self.images, item.rarity)
        }
    }

    private func makeLinkArray(for item: ItemDetail) -> [String] {
        var urls = [item.icon]
        if let url = item.featured {
            urls.append(url)
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

    private func positionImageDetailView() {
        view.addSubview(imageDetailView)
        imageDetailView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageDetailView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topConstraint = imageDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height)
        bottomConstraint = imageDetailView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: view.bounds.height
        )
        [topConstraint, bottomConstraint].forEach { $0?.isActive = true }
    }

    private func setUpImagesController() {
        imagesController.didSelectImage = { image in
            self.showImage(image)
        }
    }

    private func showImage(_ image: UIImage) {
        navigationController?.navigationBar.isHidden = true
        imageDetailView.showImage(image)
        topConstraint?.constant = 0
        bottomConstraint?.constant = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }

}
