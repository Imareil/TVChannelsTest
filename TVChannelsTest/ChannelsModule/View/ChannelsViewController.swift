// ChannelsViewController.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ChannelsViewController: UIViewController {
    var presenter: ChannelsViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        presenter?.getChannels(view: self)
    }

    // MARK: Public Methods

    // MARK: Private Methods

    private func setCollectionView() {
//        collectionView.frame = view.bounds
    }
}

extension ChannelsViewController: ChannelsViewProtocol {
    func updateData(_ channels: [Channel]) {
//        collectionView.reloadData()
    }
}
