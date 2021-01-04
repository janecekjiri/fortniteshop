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
        Service.shared.fetchAllItems { allItemsModels in
            guard let allItemsModels = allItemsModels else {
                self.handleFetchError()
                return
            }
            self.handleFetchedData(allItemsModels)
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
    }
}

// MARK: - Filtering and Sorting Methods
extension FilteredItemController {
    private func filterItems(_ items: [ListItem]) {
        var tempItems = items
        tempItems.removeAll { $0.rarity == .unknown }
        switch filter.itemsFilter {
        case .all:
            self.sortAllItems(&tempItems)
        case .rarity(let rarity):
            self.filterByRarity(rarity, items: &tempItems)
        case .itemType(let itemType):
            self.filterByItemType(itemType, items: &tempItems)
        }

        self.makeItems(&tempItems)
    }

    private func sortAllItems(_ items: inout [ListItem]) {
        items.sort { (item1, item2) -> Bool in
            if item1.rarity == item2.rarity {
                return item1.name < item2.name
            }
            return item1.rarity > item2.rarity
        }
    }

    private func filterByRarity(_ rarity: Rarity, items: inout [ListItem]) {
        items.removeAll { $0.rarity != rarity }
        items.sort { $0.name < $1.name }
    }

    private func filterByItemType(_ type: ItemType, items: inout [ListItem]) {
        items.removeAll { $0.type != type }
        items.sort { (item1, item2) -> Bool in
            if item1.rarity == item2.rarity {
                return item1.name < item2.name
            }
            return item1.rarity > item2.rarity
        }
    }

    private func makeItems(_ items: inout [ListItem]) {
        let session = URLSession.shared
        items.enumerated().forEach { index, item in
            let imageTask = ImageTask(url: item.fullBackground, session: session)
            imageTask.didDownloadImage = {
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
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
        guard let itemCell = cell as? ImageCell else {
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
        items[indexPath.item].1.resume()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        items[indexPath.item].1.pause()
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
