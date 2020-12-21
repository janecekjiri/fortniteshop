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

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let searchCell = cell as? ImageCell else {
            return cell
        }
        searchCell.backgroundColor = .red
        return searchCell
    }
}

extension SearchItemsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
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
