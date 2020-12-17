//
//  DatesController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class DatesController: UICollectionViewController {

    private let dateCellId = "dateCell"

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: dateCellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath)
        guard let dateCell = cell as? DateCell else {
            return cell
        }
        let darkGray = UIColor(red: 52/255.0, green: 52/255.0, blue: 52/255.0, alpha: 1.0)
        let lightGray = UIColor(red: 62/255.0, green: 62/255.0, blue: 62/255.0, alpha: 1.0)
        dateCell.backgroundColor = indexPath.item % 2 == 0 ? darkGray : lightGray
        return dateCell
    }
}

extension DatesController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: view.frame.width, height: 30)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}
