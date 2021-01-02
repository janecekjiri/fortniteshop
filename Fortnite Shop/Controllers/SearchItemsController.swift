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

        Service.shared.fetchAllItems { allItemsModel in
            guard let allItemsModel = allItemsModel else {
                self.setUpAfterFetch()
                return
            }

            self.fillItems(with: allItemsModel.items, for: searchedText)
            DispatchQueue.main.async {
                self.setUpAfterFetch()
            }
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

    private func fillItems(with listItems: [ListItem], for searchedText: String) {
        var filteredItems = listItems
        filteredItems.removeAll { !$0.name.lowercased().contains(searchedText.lowercased()) }
        let session = URLSession.shared
        filteredItems.enumerated().forEach { index, listItem in
            let imageTask = ImageTask(url: listItem.fullBackground, session: session)
            imageTask.didDownloadImage = {
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
            self.items.append((listItem, imageTask))
        }
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
           guard let searchCell = cell as? ImageCell else {
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
