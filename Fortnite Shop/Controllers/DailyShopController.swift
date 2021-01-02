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
    private var items = [(DailyShopItem, ImageTask)]()
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
        prepareForFetch()
        Service.shared.fetchDailyShop { dailyShop in
            guard let dailyShop = dailyShop else {
                self.handleFetchError()
                return
            }

            // TODO: Move this sort to DailyShopModel
            var dailyShopItems = dailyShop.items
            dailyShopItems.sort { lhs, rhs -> Bool in
                return lhs > rhs
            }

            let session = URLSession.shared
            dailyShopItems.enumerated().forEach { index, item in
                let imageTask = ImageTask(url: item.fullBackground, session: session)
                imageTask.didDownloadImage = {
                    self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                }
                self.items.append((item, imageTask))
            }

            DispatchQueue.main.async {
                self.setUpAfterFetch()
            }
        }
    }

    private func prepareForFetch() {
        items.removeAll()
        isFetchingData = true
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = false
    }

    private func setUpAfterFetch() {
        activityIndicator.stopAnimating()
        collectionView.reloadData()
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        isFetchingData = false
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

// MARK: - UICollectionView Setup Methods
extension DailyShopController {
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

        let image = items[indexPath.item].1.image
        let item = items[indexPath.item].0
        dailyShopCell.showFullBackgroundImage(image, for: item.rarity)

        return dailyShopCell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        items[indexPath.row].1.resume()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        items[indexPath.row].1.pause()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemDetailController = ItemDetailController(for: items[indexPath.item].0)
        navigationController?.pushViewController(itemDetailController, animated: true)
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
        return .init(top: 0, left: 10, bottom: 10, right: 10)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }

}

// MARK: - UICollectionView Section Headers Layout Methods
extension DailyShopController {
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
