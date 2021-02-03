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

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.font = UIFont.fortniteFont(ofSize: 15)
        label.text = " BACK AFTER +100 DAYS! "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        positionImageView(backgroundImageView)
        positionImageView(itemImageView)
        positionTag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionTag() {
        addSubview(tagLabel)
        tagLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tagLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tagLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tagLabel.isHidden = true
    }

    func displayTag(with text: String) {
        tagLabel.text = text
        tagLabel.isHidden = false
    }

    func hideTag() {
        tagLabel.isHidden = true
    }

    private func positionImageView(_ imageView: UIImageView) {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func showFullBackgroundImage(_ image: UIImage?, for rarity: Rarity) {
        if image == nil {
            showRarityBackground(for: rarity, using: itemImageView)
            itemImageView.layer.borderWidth = 2
        } else {
            itemImageView.image = image
            itemImageView.layer.borderWidth = 0
        }
    }

    func showTransparentImage(_ image: UIImage?, withBackgroundRarity rarity: Rarity) {
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
