//
//  FilteredItemController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 03/01/2021.
//  Copyright © 2021 Jiri Janecek. All rights reserved.
//

import UIKit

class FilteredItemController: UICollectionViewController {

    private let cellId = "cellId"
    private let filter: FilterModel
    private var items = [(ListItem, ImageTask)]()
    private var isDisappearing = false

    private let activityIndicator = UIActivityIndicatorView.makeLargeWhiteIndicator()

    init(filter: FilterModel) {
        self.filter = filter
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        setupNavigationBar()
        setUpActivityIndicator()
        fetchData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isDisappearing = true
        items.forEach { item in
            item.1.pause()
        }
        items.removeAll()
    }

}

// MARK: - Setup Methods
extension FilteredItemController {
    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    private func setupNavigationBar() {
        navigationItem.title = filter.title
    }
}

// MARK: - Networking and Support Methods
extension FilteredItemController {
    private func fetchData() {
        Service.shared.fetchAllItems { [weak self] allItemsModels in
            guard let allItemsModels = allItemsModels else {
                self?.handleFetchError()
                return
            }
            self?.handleFetchedData(allItemsModels)
        }
    }

    private func handleFetchedData(_ data: ListItemsModel) {
        filterItems(data.items)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }

    private func handleFetchError() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        showErrorAlert()
    }

    private func showErrorAlert() {
        let alertController = UIAlertController.makeErrorAlertController(
            message: "We were not able to obtain items you were looking for. Please try it later"
        ) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true)
        }
    }
}

// MARK: - Filtering and Sorting Methods
extension FilteredItemController {
    private func filterItems(_ items: [ListItem]) {
        var tempItems = items
        tempItems.removeAll { $0.rarity == .unknown }
        switch filter.itemsFilter {
        case .all:
            break
        case .rarity(let rarity):
            tempItems.removeAll { $0.rarity != rarity }
        case .itemType(let itemType):
            tempItems.removeAll { $0.type != itemType }
        }

        makeItems(&tempItems)
    }

    private func makeItems(_ items: inout [ListItem]) {
        let session = URLSession.shared
        items.enumerated().forEach { index, item in
            let imageTask = ImageTask(url: item.fullBackground, session: session)
            imageTask.didDownloadImage = { [weak self] in
                self?.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
            self.items.append((item, imageTask))
        }
    }
}

// MARK: - UICollectionView Setup Methods
extension FilteredItemController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard
            let itemCell = cell as? ImageCell,
            indexPath.item < items.count
        else {
            return cell
        }
        let item = items[indexPath.item].0
        let imageTask = items[indexPath.item].1
        itemCell.showFullBackgroundImage(imageTask.image, for: item.rarity)
        return itemCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item].0
        let itemDetailController = ItemDetailController(for: item)
        navigationController?.pushViewController(itemDetailController, animated: true)
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if !isDisappearing {
            items[indexPath.item].1.resume()
        }
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if !isDisappearing {
            items[indexPath.item].1.pause()
        }
    }

}

// MARK: - UICollectionView Layout Methods
extension FilteredItemController: UICollectionViewDelegateFlowLayout {
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
}
