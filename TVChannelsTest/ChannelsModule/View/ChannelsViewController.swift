// ChannelsViewController.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ChannelsViewController: UIViewController {
    // MARK: - UI Components

    private var channelsView: ChannelsView!

    // MARK: - Public Properties

    var presenter: ChannelsViewPresenterProtocol?

    // MARK: - Init

    init(presenter: ChannelsViewPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        channelsView = ChannelsView(presenter: presenter)
        channelsView.backgroundColor = Colors.backGround
        view = channelsView
        presenter.getChannels(view: channelsView)
    }

    // MARK: - Viewcontroller (ChannelsViewController)

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
