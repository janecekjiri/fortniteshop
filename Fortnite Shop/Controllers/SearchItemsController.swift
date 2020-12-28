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
    private var items = [(ListItem, UIImage)]()

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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let searchCell = cell as? ImageCell else {
            return cell
        }
        searchCell.showImage(items[indexPath.row].1)
        return searchCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemDetailController = ItemDetailController(for: items[indexPath.item].0)
        navigationController?.pushViewController(itemDetailController, animated: true)
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

        Service.shared.fetchAllItems { allItemsModel in
            guard let allItemsModel = allItemsModel else {
                self.setUpAfterFetch()
                return
            }

            var tempItems = allItemsModel.items
            tempItems.removeAll { !$0.name.lowercased().contains(searchedText.lowercased()) }

            let dispatchGroup = DispatchGroup()
            tempItems.forEach { item in
                dispatchGroup.enter()
                self.fetchImage(for: item) {
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                // TODO: Test that this works. If it crashes, put it into DispatchQueue.main
                self.setUpAfterFetch()
            }
        }
    }

    private func fetchImage(for item: ListItem, completion: @escaping () -> Void) {
        Service.shared.fetchImage(url: item.fullBackground) { image in
            guard let image = image else {
                completion()
                return
            }
            self.items.append((item, image))
            completion()
        }
    }

    private func prepareForFetch() {
        items.removeAll()
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = false
        hasSearched = true
        activityIndicator.startAnimating()
    }

    private func setUpAfterFetch() {
        activityIndicator.stopAnimating()
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        collectionView.reloadData()
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
