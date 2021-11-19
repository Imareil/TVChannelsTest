// ItemCollectionViewCell.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {

    //MARK: - Private Properties

    private let itemNameLabel = UILabel()
    private let view = UIView()

    //MARK: - Public Methods

    func configureCell(itemName: String) {
        view.frame = CGRect(x: 5, y: 5, width: bounds.width - 10, height: bounds.height - 10)
        view.backgroundColor = .darkGray
        addSubview(view)

        itemNameLabel.frame = CGRect(x: 5, y: 0, width: view.bounds.width - 10, height: 20)
        itemNameLabel.center.y = view.center.y
        itemNameLabel.text = itemName
        backgroundColor = .lightGray
        view.addSubview(itemNameLabel)
    }
}
