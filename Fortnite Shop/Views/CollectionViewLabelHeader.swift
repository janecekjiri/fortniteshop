//
//  CollectionViewLabelHeader.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 11/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class CollectionViewLabelHeader: UICollectionReusableView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
