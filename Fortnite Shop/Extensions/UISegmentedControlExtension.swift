//
//  UISegmentedControlExtension.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 19/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    static func makeSegmentedControl(items: [Any]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }

    static func makeGrayYellowSegmentedControl(items: [Any]) -> UISegmentedControl {
        let segmentedControl = makeSegmentedControl(items: items)
        let segmentYellow = UIColor.segmentControlYellow
        let segmentGray = UIColor.segmentControlGray
        segmentedControl.backgroundColor = segmentGray
        segmentedControl.selectedSegmentTintColor = segmentYellow
        segmentedControl.setTitleTextAttributes([.foregroundColor: segmentYellow], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        return segmentedControl
    }
}
