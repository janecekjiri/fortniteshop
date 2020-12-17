//
//  DateCellHeader.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class DateCellHeader: UICollectionReusableView {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let daysAgoLabel: UILabel = {
        let label = UILabel()
        label.text = "Days Ago"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .dateControllerBorder
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.dateControllerCellDarkGray
        addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        let stackView = UIStackView(arrangedSubviews: [dateLabel, daysAgoLabel])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
