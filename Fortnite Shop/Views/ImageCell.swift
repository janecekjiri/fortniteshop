//
//  ImageCell.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let itemImageView: UIImageView = {
        let view = UIImageView()
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        positionBackgroundImageView()
        positionImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionImageView() {
        addSubview(itemImageView)
        itemImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        itemImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        itemImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func positionBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func showImage(_ image: UIImage?, for rarity: Rarity) {
        if image == nil {
            showRarityBackground(for: rarity, using: itemImageView)
            itemImageView.layer.borderWidth = 2
        } else {
            itemImageView.image = image
            itemImageView.layer.borderWidth = 0
        }
    }

    func showImage(_ image: UIImage?, withBackgroundRarity rarity: Rarity) {
        if image == nil {
            backgroundImageView.layer.borderWidth = 2
        } else {
            itemImageView.image = image
            itemImageView.layer.borderColor = UIColor.rarityBorderColor(for: rarity).cgColor
            itemImageView.layer.borderWidth = 2
        }
        showRarityBackground(for: rarity, using: backgroundImageView)
    }

    private func showRarityBackground(for rarity: Rarity, using imageView: UIImageView) {
        imageView.layer.borderColor = UIColor.rarityBorderColor(for: rarity).cgColor
        imageView.image = UIImage.rarityBackground(for: rarity)
    }

}
