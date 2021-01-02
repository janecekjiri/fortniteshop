//
//  ItemDetailController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {

    private let item: ItemDetailProtocol
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?

    private let itemDetailView = ItemDetailView()
    private let imageDetailView = ImageDetailView()
    private let activityIndicator = UIActivityIndicatorView.makeLargeWhiteIndicator()
    private var images = [UIImage]()
    private var setItems = [(ItemDetail, UIImage)]()

    private let datesController = DatesController()
    private let imagesController = ImagesController()
    private let setController = SetController()

    init(for item: ItemDetailProtocol) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpSegmentedControllers()
        addChildControllers()
        positionActivityIndicator()
        setUpImageDetailView()
        fetchItemDetail()
    }

}

// MARK: - Setup Methods
extension ItemDetailController {

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

    private func setUpDetailView(for item: ItemDetail, with image: UIImage) {
        view.addSubview(itemDetailView)
        itemDetailView.setUpView(for: item, with: image)
        itemDetailView.didChangeSegment = handleSwitchedSegments(to:)
        itemDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        itemDetailView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        itemDetailView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setUpImagesController() {
        imagesController.didSelectImage = { image in
            self.showImage(image)
        }
    }

    private func setUpSetController() {
        setController.didPressSet = { setItem in
            let itemDetailController = ItemDetailController(for: setItem)
            self.navigationController?.pushViewController(itemDetailController, animated: true)
        }
    }

    private func setUpSegmentedControllers() {
        setUpImagesController()
        setUpSetController()
    }

    private func setUpControllers(for itemDetail: ItemDetail) {
        datesController.addDates(itemDetail.history)
        imagesController.set(itemDetail: itemDetail)
        if !itemDetail.itemsInSet.isEmpty {
            setController.insert(identitites: itemDetail.itemsInSet)
            DispatchQueue.main.async {
                self.addChild(controller: self.setController)
            }
        }
    }

}

// MARK: - Positioning Methods
extension ItemDetailController {

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

    private func positionActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

}

// MARK: - Custom Methods
extension ItemDetailController {

    private func addChildControllers() {
        addChild(controller: datesController, doesHaveBorder: true)
        addChild(controller: imagesController)
    }

    private func addChild(controller: UIViewController, doesHaveBorder: Bool = false) {
        addChild(controller)
        itemDetailView.addChild(view: controller.view, doesHaveBorder: doesHaveBorder)
        controller.didMove(toParent: self)
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

    private func showErrorAlert() {
        let alertController = UIAlertController.makeErrorAlertController(
            message: "We were not able to obtain item's details. Please try it later"
        )
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true)
        }
    }

    private func handleFetchError() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        self.showErrorAlert()
        // TODO: Dismiss current VC and return to the previous one
    }

    private func handleFinishedFetch(for itemDetail: ItemDetail, with image: UIImage) {
        activityIndicator.stopAnimating()
        navigationItem.title = itemDetail.name
        setUpDetailView(for: itemDetail, with: image)
        positionImageDetailView()
    }

    private func handleSwitchedSegments(to index: Int) {
        imagesController.setIsBeingDisplayed(index == 1)
        setController.setIsBeingDisplayed(index == 2)
    }

}

// MARK: - Networking
extension ItemDetailController {

    private func fetchItemDetail() {
        Service.shared.fetchItemDetail(for: item) { itemDetail in
            guard let itemDetail = itemDetail else {
                self.handleFetchError()
                return
            }
            self.setUpControllers(for: itemDetail)
            DispatchQueue.main.async {
                self.imageDetailView.setRarityBackground(for: itemDetail.rarity)
            }
            Service.shared.fetchImage(url: itemDetail.fullBackground) { image in
                guard let image = image else {
                    return
                }
                DispatchQueue.main.async {
                    self.handleFinishedFetch(for: itemDetail, with: image)
                }
            }
        }
    }

}
