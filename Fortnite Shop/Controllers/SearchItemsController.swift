//
//  SearchItemsController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 21/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class SearchItemsController: UICollectionViewController {

    private let cellId = "cellId"
    private let headerId = "headerId"
    private var hasSearched = false
    private var items = [(ListItem, ImageTask)]()
    private var isFetching = false

    private let activityIndicator = UIActivityIndicatorView.makeLargeWhiteIndicator()

    private let searchController = UISearchController(searchResultsController: nil)

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setUpNavigationItem()
        positionActivityIndicator()
        registerCells()
    }
}

// MARK: - Setup Methods
extension SearchItemsController {
    private func setUpSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func setUpNavigationItem() {
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func positionActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    }

    private func registerCells() {
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(
            CollectionViewLabelHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerId
        )
    }
}

// MARK: - UISearchBarDelegate And Helper Methods
extension SearchItemsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedText = searchBar.text else {
            return
        }
        prepareForFetch()

        Service.shared.fetchAllItems { [weak self] allItemsModel in
            guard let allItemsModel = allItemsModel else {
                self?.handleFetchError()
                return
            }

            self?.fillItems(with: allItemsModel.items, for: searchedText)
            DispatchQueue.main.async {
                self?.setUpAfterFetch()
            }
        }
    }

    private func fillItems(with listItems: [ListItem], for searchedText: String) {
        var filteredItems = listItems
        filteredItems.removeAll { !$0.name.lowercased().contains(searchedText.lowercased()) }
        filteredItems.sort { item1, item2 -> Bool in
            if item1.rarity == item2.rarity {
                return item1.name < item2.name
            }
            return item1.rarity > item2.rarity
        }
        let session = URLSession.shared
        filteredItems.enumerated().forEach { index, listItem in
            let imageTask = ImageTask(url: listItem.fullBackground, session: session)
            imageTask.didDownloadImage = { [weak self] in
                self?.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
            self.items.append((listItem, imageTask))
        }
    }
}

// MARK: - Handling Data Fetch
extension SearchItemsController {
    private func showErrorAlert() {
        let alertController = UIAlertController.makeErrorAlertController(
            message: "We were not able to obtain items you were looking for. Please try it later"
        )
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true)
        }
    }

    private func handleFetchError() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        showErrorAlert()
        isFetching = false
    }

    private func prepareForFetch() {
        isFetching = true
        items.forEach { item in
            item.1.pause()
        }
        items.removeAll()
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = false
        hasSearched = true
        activityIndicator.startAnimating()
    }

    private func setUpAfterFetch() {
        isFetching = false
        activityIndicator.stopAnimating()
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        collectionView.reloadData()
        collectionView.setContentOffset(CGPoint(x: 0, y: -1000), animated: false)
    }
}

// MARK: - UICollectionView Setup Methods
extension SearchItemsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard
            let searchCell = cell as? ImageCell,
            indexPath.item < items.count
        else {
            return cell
        }
        let image = items[indexPath.item].1.image
        let item = items[indexPath.item].0
        searchCell.showFullBackgroundImage(image, for: item.rarity)
        return searchCell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if !isFetching {
            items[indexPath.item].1.resume()
        }

    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if !isFetching && indexPath.item < items.count {
            items[indexPath.item].1.pause()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemDetailController = ItemDetailController(for: items[indexPath.item].0)
        navigationController?.pushViewController(itemDetailController, animated: true)
    }
}

// MARK: - UICollectionView Layout Methods
extension SearchItemsController: UICollectionViewDelegateFlowLayout {

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

// MARK: - UICollectionView Header Methods
extension SearchItemsController {

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerId,
            for: indexPath
        )
        guard let labelHader = header as? CollectionViewLabelHeader else {
            return header
        }
        if hasSearched {
            labelHader.setTitle("\(items.count) items found")
        }
        return labelHader
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return .init(width: view.frame.width, height: 40)
    }

}
