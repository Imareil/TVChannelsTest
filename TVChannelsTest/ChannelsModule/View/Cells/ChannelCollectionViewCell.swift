// ChannelCollectionViewCell.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ChannelCollectionViewCell: UICollectionViewCell {

    //MARK: - private Properties

    private let indexLabel = UILabel()
    private let channelNameLabel = UILabel()
    private let view = UIView()

    //MARK: - Public Methods

    func configureCell(index: Int, channelName: String?) {
        view.frame = CGRect(x: 5, y: 5, width: bounds.width - 10, height: bounds.height - 10)
        view.backgroundColor = .darkGray
        addSubview(view)

        indexLabel.frame = CGRect(x: 10, y: 5, width: 100, height: 30)
        indexLabel.text = "\(index)"
        view.addSubview(indexLabel)

        channelNameLabel.frame = CGRect(x: 10, y: 35, width: 100, height: 30)
        channelNameLabel.text = channelName
        backgroundColor = .lightGray
        view.addSubview(channelNameLabel)
    }
}
