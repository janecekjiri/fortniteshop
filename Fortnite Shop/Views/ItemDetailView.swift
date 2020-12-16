//
//  ItemDetailView.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 14/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ItemDetailView: UIView {

    private let descriptionLabel = UILabel.makeCenteredLabel()
    private let releaseDateLabel = UILabel.makeCenteredLabel()
    private let lastSeenLabel = UILabel.makeCenteredLabel()
    private let occurrencesLabel = UILabel.makeCenteredLabel()

    private let imageView = UIImageView()

    private lazy var historyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateLabel, lastSeenLabel, occurrencesLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let segmentedControl: UISegmentedControl = {
        let items = ["History", "Images"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: returnImageViewWidth()).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
    }

    private func positionStackView() {
        addSubview(historyStackView)
        historyStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        historyStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        historyStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }

    private func positionSegmentedControl() {
        addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: historyStackView.bottomAnchor, constant: 15).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func positionViews() {
        positionDescriptionLabel()
        positionImageView()
        positionStackView()
        positionSegmentedControl()
    }

    func setUpView(for item: ItemDetail, with image: UIImage) {
        descriptionLabel.text = "\"\(item.description)\""
        imageView.image = image

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long

        releaseDateLabel.setAttributedHistoryText(
            withBoldText: "Released: ",
            withNormalText: "\(dateFormatter.string(from: item.releaseDate))"
        )
        lastSeenLabel.setAttributedHistoryText(
            withBoldText: "Last seen: ",
            withNormalText: "\(dateFormatter.string(from: item.lastAppearance))"
        )
        occurrencesLabel.setAttributedHistoryText(
            withBoldText: "Occurrences: ",
            withNormalText: "\(item.history.count)"
        )

        if !item.itemsInSet.isEmpty {
            segmentedControl.insertSegment(withTitle: "Set", at: 2, animated: false)
        }
    }

    @objc func segmentDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("History")
        case 1:
            print("Images")
        default:
            print("Set")
        }
    }

    func addChild(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
}
