// ChannelsView.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ChannelsView: UIView {
    lazy var collectionView = createCollectionView()

    var presenter: ChannelsViewPresenterProtocol?

    convenience init(presenter: ChannelsViewPresenterProtocol) {
        self.init()
        self.presenter = presenter
        addSubview(collectionView)
        configureConstraints()
    }
}
