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
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(
            CollectionViewLabelHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerId
        )
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
}

// MARK: - UISearchBarDelegate Methods
extension SearchItemsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        items.removeAll()
        hasSearched = true
        guard let searchedText = searchBar.text else {
            return
        }
        activityIndicator.startAnimating()
        Service.shared.fetchAllItems { allItemsModel in
            guard let allItemsModel = allItemsModel else {
                self.activityIndicator.stopAnimating()
                return
            }
            var tempItems = allItemsModel.items
            tempItems.removeAll { !$0.name.lowercased().contains(searchedText.lowercased()) }
            let dispatchGroup = DispatchGroup()
            tempItems.forEach { item in
                dispatchGroup.enter()
                Service.shared.fetchImage(url: item.fullBackground) { image in
                    guard let image = image else {
                        dispatchGroup.leave()
                        return
                    }
                    self.items.append((item, image))
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
        }
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
