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
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setAttributedTitle(
            NSAttributedString(
                string: "Close",
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 16),
                    .foregroundColor: UIColor.white
                ]
            ),
            for: .normal
        )
        button.layer.borderWidth = 0.0
        button.addTarget(self, action: #selector(pressedCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionImageView() {
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
        positionImageView()
        positionCloseButton()
    }

    @objc func pressedCloseButton() {
        didPressCloseButton?()
    }
}
