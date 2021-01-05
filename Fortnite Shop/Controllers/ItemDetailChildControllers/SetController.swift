//
//  SetController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 20/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class SetController: UICollectionViewController {

    private let imageCellId = "imageCellId"
    private var isBeingDisplayed = false
    private var items = [(ItemDetail, ImageTask)]()

    var didPressSet: ((ItemDetail) -> Void)?

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: imageCellId)
    }
}

// MARK: - CollectionView Setup Methods
extension SetController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath)
        guard let itemCell = cell as? ImageCell else {
            return cell
        }
        let item = items[indexPath.row].0
        let image = items[indexPath.row].1.image
        itemCell.showFullBackgroundImage(image, for: item.rarity)
        return itemCell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if isBeingDisplayed {
            items[indexPath.row].1.resume()
        }
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        // TODO: Figure out why with the next line uncommented, some pictures aren't occasionally presented
        //items[indexPath.row].1.pause()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 10)/2
        return .init(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row].0
        didPressSet?(item)
    }
}

// MARK: - Custom Methods
extension SetController {
    func setIsBeingDisplayed(_ isBeingDisplayed: Bool) {
        self.isBeingDisplayed = isBeingDisplayed
        if isBeingDisplayed {
            self.collectionView.reloadData()
        } else {
            self.items.forEach { $1.pause() }
        }
    }

    private func showErrorAlert() {
        let alertController = UIAlertController.makeErrorAlertController(
            message: "We were not able to obtain information about item's set. Please try it later"
        )
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true)
        }
    }

    func insert(identitites: [String]) {
        let session = URLSession.shared
        identitites.enumerated().forEach { index, identity in
            Service.shared.fetchItemDetail(for: identity) { itemDetail in
                guard let itemDetail = itemDetail else {
                    self.showErrorAlert()
                    return
                }
                let imageTask = ImageTask(url: itemDetail.fullBackground, session: session)
                imageTask.didDownloadImage = {
                    self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                }
                self.items.append((itemDetail, imageTask))
                if index == identitites.count - 1 {
                    self.items.sort { item1, item2 -> Bool in
                        if item1.0.rarity == item2.0.rarity {
                            return item1.0.name < item2.0.name
                        }
                        return item1.0.rarity > item2.0.rarity
                    }
                }
            }
        }
    }
}
