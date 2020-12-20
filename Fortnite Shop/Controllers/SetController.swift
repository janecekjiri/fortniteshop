//
//  SetController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 20/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class SetController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let imageCellId = "imageCellId"

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: imageCellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath)
        guard let itemCell = cell as? ImageCell else {
            return cell
        }
        itemCell.backgroundColor = .red
        return itemCell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 10)/2
        return .init(width: width, height: width)
    }
}
