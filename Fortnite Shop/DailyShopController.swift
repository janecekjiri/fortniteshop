//
//  DailyShopController.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class DailyShopController: UICollectionViewController {

    let dailyShopCellId = "dailyShopCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DailyShopCell.self, forCellWithReuseIdentifier: dailyShopCellId)
    }

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyShopCellId, for: indexPath)
        guard let dailyShopCell = cell as? DailyShopCell else {
            return cell
        }
        return dailyShopCell
    }
}
