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
    private let headerId = "header"
    private var dates = [Date]()
    private let dateFormatter = DateFormatter()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: dateCellId)
        collectionView.register(
            DateCellHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerId
        )
        dateFormatter.dateStyle = .long
    }
}

// MARK: - Collection View Header Setup Methods
extension DatesController {
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
        return header
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return .init(width: view.frame.width, height: 30)
    }
}

// MARK: - CollectionView Setup Methods
extension DatesController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath)
        guard let dateCell = cell as? DateCell else {
            return cell
        }
        let darkGray = UIColor.dateControllerCellDarkGray
        let lightGray = UIColor.dateControllerCellLightGray
        dateCell.backgroundColor = indexPath.item % 2 == 0 ? lightGray : darkGray

        let date = dates[indexPath.item]
        dateCell.setCell(date: formatDate(date), daysAgo: calculateDaysAgo(for: date))
        return dateCell
    }

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

// MARK: - Custom Methods
extension DatesController {
    func addDates(_ dates: [Date]) {
        self.dates = dates
        self.dates.reverse()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func calculateDaysAgo(for date: Date) -> String {
        let daysAgo = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
        return "\(daysAgo)"
    }
}
