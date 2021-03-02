//
//  ImageDetailView.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 17/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ImageDetailView: UIView {

    var didPressCloseButton: (() -> Void)?

    private let closeButton: UIButton = {
        let button = UIButton.makeBorderlessBoldButton(with: "Close")
        button.addTarget(self, action: #selector(pressedCloseButton), for: .touchUpInside)
        return button
    }()

    private let backgroundImageView = UIImageView(contentMode: .scaleAspectFit)
    private let imageView = UIImageView(contentMode: .scaleAspectFit)

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        imageView.isOpaque = false
        positionImageView(backgroundImageView)
        positionImageView(imageView)
        positionCloseButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionImageView(_ imageView: UIImageView) {
        addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
    }

    private func positionCloseButton() {
        addSubview(closeButton)
        closeButton.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func showImage(_ image: UIImage) {
        imageView.image = image
    }

    func setRarityBackground(for rarity: Rarity) {
        backgroundImageView.image = UIImage.rarityBackground(for: rarity)
    }

    @objc func pressedCloseButton() {
        didPressCloseButton?()
    }
}
