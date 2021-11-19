// TimeCollectionViewCell.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class TimeCollectionViewCell: UICollectionViewCell {

    //MARK: - Provate Properties

    private let timeLabel = UILabel()
    private let view = UIView()

    //MARK: - Public Methods

    func configureCell(time: String?) {
        view.frame = CGRect(x: 5, y: 5, width: bounds.width - 10, height: bounds.height - 10)
        view.backgroundColor = .darkGray
        addSubview(view)

        timeLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 10, height: 50)
        timeLabel.center = view.center
        timeLabel.textAlignment = .center
        timeLabel.numberOfLines = 0
        timeLabel.text = time
        backgroundColor = .lightGray
        view.addSubview(timeLabel)
    }
}
