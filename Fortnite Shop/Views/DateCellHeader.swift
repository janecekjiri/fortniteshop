//
//  DateCellHeader.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class DateCellHeader: UICollectionReusableView {

    private let dateLabel = UILabel.makeBoldLabel(ofSize: 16, with: "Date")
    private let daysAgoLabel = UILabel.makeBoldLabel(ofSize: 16, with: "Days Ago")

    private let separatorView = UIView.makeView(ofColor: .dateControllerBorder)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.dateControllerCellDarkGray
        positionSeparatorView()
        setUpStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionSeparatorView() {
        addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setUpStackView() {
        let stackView = UIStackView.makeHorizontalStackView(
            arrangedSubview: [dateLabel, daysAgoLabel],
            distribution: .fillEqually
        )
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }
}
