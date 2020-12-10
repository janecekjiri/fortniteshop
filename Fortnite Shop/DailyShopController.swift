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
        Service.shared.fetchDailyShop { dailyShop, error in
            if let error = error {
                print("Apologies, but we have encountered error: \(error)")
            }

            guard let dailyShop = dailyShop else {
                print("We have ran into a problem. We weren't able to get the daily shop")
                return
            }

            print(dailyShop)
        }
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

extension DailyShopController: UICollectionViewDelegateFlowLayout {

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
