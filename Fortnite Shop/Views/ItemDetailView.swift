//
//  ItemDetailView.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ItemDetailView: UIView {

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "\"Always remember your first run.\""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let releaseDateLabel = UILabel.makeHistoryLabel(withBoldText: "Released: ", withNormalText: "December 10, 2018")

    let lastSeenLabel = UILabel.makeHistoryLabel(withBoldText: "Last seen: ", withNormalText: "July 29, 2020")

    let occurrencesLabel = UILabel.makeHistoryLabel(withBoldText: "Occurrences: ", withNormalText: "23")

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        positionViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }

    private func returnImageViewWidth() -> NSLayoutDimension {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        view.rightAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
        return view.widthAnchor
    }

    private func positionImageView() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: returnImageViewWidth()).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
    }

    private func positionStackView() {
        let stackView = UIStackView(
            arrangedSubviews: [releaseDateLabel, lastSeenLabel, occurrencesLabel]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }

    private func positionViews() {
        positionDescriptionLabel()
        positionImageView()
        positionStackView()
    }

}
