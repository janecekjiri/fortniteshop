//
//  DateCell.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {

    private let dateLabel = UILabel.makeSystemLabel(ofSize: 14)
    private let daysAgoLabel = UILabel.makeSystemLabel(ofSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpStackView() {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, daysAgoLabel])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }

    func setCell(date: String, daysAgo: String) {
        dateLabel.text = date
        daysAgoLabel.text = daysAgo
    }

}
