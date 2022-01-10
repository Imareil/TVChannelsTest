// ChannelCollectionViewCell.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ChannelCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components

    private let indexLabel = UILabel()
    private let channelNameLabel = UILabel()
    private let view = UIView()

    // MARK: - Public Methods

    func configureCell(index: Int, channelName: String?) {
        view.backgroundColor = Colors.cellBackGround
        view.layer.cornerRadius = Constants.cellCornerRadius
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = Colors.border?.cgColor

        addSubview(view)

        indexLabel.frame = CGRect(x: 10, y: 5, width: 100, height: 30)
        indexLabel.text = "\(index)"
        view.addSubview(indexLabel)

        channelNameLabel.frame = CGRect(x: 10, y: 35, width: 100, height: 30)
        channelNameLabel.text = channelName
        backgroundColor = Colors.backGround
        view.addSubview(channelNameLabel)

        makeConstraints()
    }

    private func makeConstraints() {
        view.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().inset(5)
        }

        indexLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(10)
        }

        channelNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
