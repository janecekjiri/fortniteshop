//
//  DailyShopController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class DailyShopController: UICollectionViewController {

    private let dailyShopCellId = "dailyShopCellId"
    private let collectionViewHeader = "collectionViewHeader"
    private var items = [(DailyShopItem, UIImage)]()
    private var isFetchingData = true
    private let dateFormatter = DateFormatter()

    private let activityIndicator = UIActivityIndicatorView.makeLargeWhiteIndicator()

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        prepareActivityIndicator()
        registerCells()
        fetchDailyShop()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyShopCellId, for: indexPath)
        guard let dailyShopCell = cell as? ImageCell else {
            return cell
        }
        dailyShopCell.showImage(items[indexPath.item].1)
        return dailyShopCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemDetailController = ItemDetailController(for: items[indexPath.item].0)
        navigationController?.pushViewController(itemDetailController, animated: true)
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: collectionViewHeader,
            for: indexPath
            ) as? CollectionViewLabelHeader {
            header.setTitle(returnTodaysDate().uppercased())
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return .init(width: view.frame.width, height: 40)
    }
}

// MARK: - Custom Methods
extension DailyShopController {

    private func registerCells() {
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: dailyShopCellId)
        collectionView.register(
            CollectionViewLabelHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: collectionViewHeader
        )
    }

    private func setupNavigationBar() {
        navigationItem.title = "Item Shop"
        let rightButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        rightButton.tintColor = .label
        navigationItem.rightBarButtonItem = rightButton
    }

    private func positionActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    }

    private func prepareActivityIndicator() {
        positionActivityIndicator()
        activityIndicator.startAnimating()
    }

    private func returnTodaysDate() -> String {
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: Date())
    }

    private func fetchDailyShop() {
        items.removeAll()
        isFetchingData = true
        collectionView.isScrollEnabled = false
        Service.shared.fetchDailyShop { dailyShop in
            guard let dailyShop = dailyShop else {
                self.handleFetchError()
                return
            }

            let dispatchGroup = DispatchGroup()
            dailyShop.items.forEach { item in
                dispatchGroup.enter()
                Service.shared.fetchImage(url: item.fullBackground) { image in
                    guard let image = image else {
                        return
                    }
                    self.items.append((item, image))
                    // TODO: Move this sort to DailyShopModel
                    self.items.sort { lhs, rhs -> Bool in
                        return lhs.0 > rhs.0
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
                self.collectionView.isScrollEnabled = true
                self.isFetchingData = false
            }
        }
    }

    // TODO: Fix
    @objc private func refresh() {
        if !isFetchingData {
            activityIndicator.startAnimating()
            fetchDailyShop()
        }
    }

    private func showErrorAlert() {
        let alertController = UIAlertController.makeErrorAlertController(
            message: "We were not able to obtain items in today's shop. Please try it later"
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
        self.isFetchingData = false
    }
}

// MARK: - UICollectionView Layout Methods
extension DailyShopController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 30)/2
        return .init(width: width, height: width)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }

}
