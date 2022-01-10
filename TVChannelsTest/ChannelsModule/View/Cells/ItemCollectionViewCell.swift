// ItemCollectionViewCell.swift
// Copyright © Dmi3. All rights reserved.

import SnapKit
import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components

    private let itemNameLabel = UILabel()
    private let view = UIView()

    // MARK: - Public Methods

    func configureCell(itemName: String) {
        view.backgroundColor = Colors.cellBackGround
        view.layer.cornerRadius = Constants.cellCornerRadius
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = Colors.border?.cgColor
        addSubview(view)

        itemNameLabel.center.y = view.center.y
        itemNameLabel.text = itemName
        itemNameLabel.numberOfLines = 0
        backgroundColor = Colors.backGround
        view.addSubview(itemNameLabel)

        makeConstraints()
    }

    private func makeConstraints() {
        view.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().inset(5)
        }

        itemNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}
