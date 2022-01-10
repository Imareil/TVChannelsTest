// TimeCollectionViewCell.swift
// Copyright © Dmi3. All rights reserved.

import SnapKit
import UIKit

final class TimeCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components

    private let timeLabel = UILabel()
    private let view = UIView()

    // MARK: - Public Methods

    func configureCell(time: String?) {
        view.backgroundColor = Colors.cellBackGround
        view.layer.cornerRadius = Constants.cellCornerRadius
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = Colors.border?.cgColor

        addSubview(view)

        timeLabel.text = time
        timeLabel.numberOfLines = 0
        timeLabel.textAlignment = .center
        backgroundColor = Colors.backGround
        view.addSubview(timeLabel)

        makeConstraints()
    }

    private func makeConstraints() {
        view.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().inset(5)
        }

        timeLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}
