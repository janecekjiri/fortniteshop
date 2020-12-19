//
//  CollectionViewLabelHeader.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 11/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class CollectionViewLabelHeader: UICollectionReusableView {

    private let titleLabel = UILabel.makeCenteredLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpTitleLabel() {
        titleLabel.font = UIFont.fortniteFont(ofSize: 25)
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
