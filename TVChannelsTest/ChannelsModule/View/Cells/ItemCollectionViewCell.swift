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
        view.backgroundColor = .darkGray
        addSubview(view)

        itemNameLabel.center.y = view.center.y
        itemNameLabel.text = itemName
        backgroundColor = .lightGray
        view.addSubview(itemNameLabel)

        makeConstraints()
    }

    private func makeConstraints() {
        view.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().inset(5)
        }

        itemNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
}
