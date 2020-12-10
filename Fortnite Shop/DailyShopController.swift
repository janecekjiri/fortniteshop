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
    var images = [UIImage]()

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

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

            var dailies = dailyShop.daily + dailyShop.featured + dailyShop.specialFeatured
            dailies += dailyShop.community + dailyShop.offers + dailyShop.specialDaily
            let dispatchGroup = DispatchGroup()

            dailies.forEach { item in
                dispatchGroup.enter()
                Service.shared.fetchImage(url: item.image) { image in
                    dispatchGroup.leave()
                    guard let image = image else {
                        return
                    }
                    self.images.append(image)
                }
            }

            dispatchGroup.notify(queue: .main) {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyShopCellId, for: indexPath)
        guard let dailyShopCell = cell as? DailyShopCell else {
            return cell
        }
        dailyShopCell.itemImageView.image = images[indexPath.item]
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
