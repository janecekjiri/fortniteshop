//
//  ItemDetailView.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ItemDetailView: UIView {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        positionImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionImageView() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        imageView.rightAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
    }

}
