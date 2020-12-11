//
//  DailyShopController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class DailyShopController: UICollectionViewController {

    let dailyShopCellId = "dailyShopCellId"
    let collectionViewHeader = "collectionViewHeader"
    var images = [UIImage]()
    var isFetchingData = true

    let activityIndicator = UIActivityIndicatorView.largeWhiteIndicator

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
        return images.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyShopCellId, for: indexPath)
        guard let dailyShopCell = cell as? DailyShopCell else {
            return cell
        }
        dailyShopCell.itemImageView.image = images[indexPath.item]
        return dailyShopCell
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
            header.titleLabel.text = returnTodaysDate().uppercased()
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
        collectionView.register(DailyShopCell.self, forCellWithReuseIdentifier: dailyShopCellId)
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
        collectionView.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    }

    private func prepareActivityIndicator() {
        positionActivityIndicator()
        activityIndicator.startAnimating()
    }

    private func returnTodaysDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: Date())
    }

    private func fetchDailyShop() {
        images.removeAll()
        isFetchingData = true
        Service.shared.fetchDailyShop { dailyShop, error in
            if error != nil {
                self.showErrorAlert()
                return
            }

            guard let dailyShop = dailyShop else {
                self.showErrorAlert()
                return
            }

            let dailies = dailyShop.daily + dailyShop.featured + dailyShop.specialFeatured
                + dailyShop.community + dailyShop.offers + dailyShop.specialDaily

            let dispatchGroup = DispatchGroup()
            dailies.forEach { item in
                dispatchGroup.enter()
                Service.shared.fetchImage(url: item.image) { image in
                    dispatchGroup.leave()
                    guard let image = image else {
                        return
                    }
                    self.images.append(image)
                }
            }

            dispatchGroup.notify(queue: .main) {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
                self.isFetchingData = false
            }
        }
    }

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
