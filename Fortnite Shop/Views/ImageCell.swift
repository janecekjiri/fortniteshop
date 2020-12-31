//
//  ImageCell.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

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

    func showImage(_ image: UIImage?) {
        itemImageView.image = image

        if image == nil {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func showImage(_ image: UIImage?, for item: DailyShopItem) {
        itemImageView.image = image

        if image == nil {
            showRarityBackground(for: item.rarity)
            itemImageView.layer.borderWidth = 2
        } else {
            itemImageView.layer.borderWidth = 0
        }
    }

    private func showRarityBackground(for rarity: Rarity) {
        switch rarity {
        case .uncommon:
            itemImageView.image = UIImage(named: "uncommon")
            itemImageView.layer.borderColor = UIColor(red: 135, green: 227, blue: 57).cgColor
        case .rare:
            itemImageView.image = UIImage(named: "rare")
            itemImageView.layer.borderColor = UIColor(red: 55, green: 209, blue: 255).cgColor
        case .epic:
            itemImageView.image = UIImage(named: "epic")
            itemImageView.layer.borderColor = UIColor(red: 233, green: 94, blue: 255).cgColor
        case .legendary:
            itemImageView.image = UIImage(named: "legendary")
            itemImageView.layer.borderColor = UIColor(red: 233, green: 141, blue: 75).cgColor
        default:
            itemImageView.image = UIImage(named: "common")
            itemImageView.layer.borderColor = UIColor(red: 177, green: 177, blue: 177).cgColor
        }
    }

}
