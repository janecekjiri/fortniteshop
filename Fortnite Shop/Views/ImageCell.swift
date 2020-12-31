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

    func showImage(_ image: UIImage?, for item: DailyShopItem) {
        itemImageView.image = image

        if image == nil {
            showRarityBackground(for: item.rarity)
            itemImageView.layer.borderWidth = 2
        } else {
            itemImageView.layer.borderWidth = 0
        }
    }

    // TODO: Add colors to UIColor extension
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
        case .darkSeries:
            itemImageView.image = UIImage(named: "darkSeries")
            itemImageView.layer.borderColor = UIColor(red: 255, green: 66, blue: 231).cgColor
        case .frozenSeries:
            itemImageView.image = UIImage(named: "frozenSeries")
            itemImageView.layer.borderColor = UIColor(red: 170, green: 208, blue: 238).cgColor
        case .shadowSeries:
            itemImageView.image = UIImage(named: "shadowSeries")
            itemImageView.layer.borderColor = UIColor(red: 110, green: 110, blue: 110).cgColor
        case .slurpSeries:
            itemImageView.image = UIImage(named: "slurpSeries")
            itemImageView.layer.borderColor = UIColor(red: 0, green: 139, blue: 222).cgColor
        case .lavaSeries:
            itemImageView.image = UIImage(named: "lavaSeries")
            itemImageView.layer.borderColor = UIColor(red: 160, green: 48, blue: 53).cgColor
        case .iconSeries:
            itemImageView.image = UIImage(named: "iconSeries")
            itemImageView.layer.borderColor = UIColor(red: 64, green: 184, blue: 199).cgColor
        case .marvel:
            itemImageView.image = UIImage(named: "marvel")
            itemImageView.layer.borderColor = UIColor(red: 239, green: 53, blue: 55).cgColor
        case .dcSeries:
            itemImageView.image = UIImage(named: "dcSeries")
            itemImageView.layer.borderColor = UIColor(red: 96, green: 148, blue: 206).cgColor
        case .starWarsSeries:
            itemImageView.image = UIImage(named: "starWarsSeries")
            itemImageView.layer.borderColor = UIColor(red: 76, green: 76, blue: 76).cgColor
        case .gamingLegendsSeries:
            itemImageView.image = UIImage(named: "gamingLegendsSeries")
            itemImageView.layer.borderColor = UIColor(red: 127, green: 120, blue: 249).cgColor
        default:
            itemImageView.image = UIImage(named: "common")
            itemImageView.layer.borderColor = UIColor(red: 177, green: 177, blue: 177).cgColor
        }
    }

}
