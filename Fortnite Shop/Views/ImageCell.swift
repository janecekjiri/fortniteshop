//
//  ImageCell.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    // TODO: Remove this
    private let activityIndicator = UIActivityIndicatorView.makeLargeWhiteIndicator()

    private let itemImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        positionActivityIndicator()
        positionImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: Remove this method
    private func positionActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func positionImageView() {
        addSubview(itemImageView)
        itemImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        itemImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        itemImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    // TODO: Remove this method
    func showImage(_ image: UIImage?) {
        itemImageView.image = image

        if image == nil {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func showImage(_ image: UIImage?, for rarity: Rarity) {
        itemImageView.image = image

        if image == nil {
            showRarityBackground(for: rarity)
            itemImageView.layer.borderWidth = 2
        } else {
            itemImageView.layer.borderWidth = 0
        }
    }

    private func showRarityBackground(for rarity: Rarity) {
        itemImageView.layer.borderColor = UIColor.rarityBorderColor(for: rarity).cgColor
        itemImageView.image = UIImage.rarityBackground(for: rarity)
    }

}
