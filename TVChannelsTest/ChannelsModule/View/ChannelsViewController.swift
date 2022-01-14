// ChannelsViewController.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ChannelsViewController: UIViewController {
    // MARK: - UI Components

    private let _view: ChannelsView

    // MARK: - Init

    init(presenter: ChannelsViewPresenterProtocol) {
        _view = ChannelsView(presenter: presenter)
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Viewcontroller (ChannelsViewController)

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("Fatal error")
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController (ChannelsViewController)

    override func loadView() {
        view = _view
        view.backgroundColor = Colors.backGround
        title = Constants.channelcVCTitle
    }
}
