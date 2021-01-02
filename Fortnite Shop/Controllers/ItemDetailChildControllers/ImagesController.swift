//
//  ImagesController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ImagesController: UICollectionViewController {

    private let cellId = "cellId"
    private var imageTasks = [ImageTask]()
    private var rarity = Rarity.unknown
    private var itemDetail: ItemDetail?
    private var isBeingDisplayed = false

    var didSelectImage: ((UIImage) -> Void)?

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
    }
}

// MARK: - CollectionView Setup Methods
extension ImagesController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageTasks.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let imageCell = cell as? ImageCell else {
            return cell
        }
        if let itemDetail = itemDetail {
            imageCell.showTransparentImage(imageTasks[indexPath.item].image, withBackgroundRarity: itemDetail.rarity)
        }
        return imageCell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if isBeingDisplayed {
            imageTasks[indexPath.row].resume()
        }
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        imageTasks[indexPath.row].pause()
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
        if let image = imageTasks[indexPath.item].image {
            didSelectImage?(image)
        }
    }
}

// MARK: - Custom Methods
extension ImagesController {
    func set(itemDetail: ItemDetail) {
        self.itemDetail = itemDetail
        makeImageTasks(for: itemDetail)
    }

    func setIsBeingDisplayed(_ isBeingDisplayed: Bool) {
        self.isBeingDisplayed = isBeingDisplayed
        if isBeingDisplayed {
            self.collectionView.reloadData()
        } else {
            self.imageTasks.forEach { $0.pause() }
        }
    }

    private func makeImageTasks(for item: ItemDetail) {
        var urls = [item.icon]
        if let url = item.featured {
            urls.append(url)
        }
        let session = URLSession.shared
        urls.enumerated().forEach { index, url in
            let imageTask = ImageTask(url: url, session: session)
            imageTask.didDownloadImage = {
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
            self.imageTasks.append(imageTask)
        }
    }
}
