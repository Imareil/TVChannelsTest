// ChannelsPresenter.swift
// Copyright © Dmi3. All rights reserved.

import Foundation

protocol ChannelsViewProtocol: AnyObject {
    func updateData()
}

protocol ChannelsViewPresenterProtocol: AnyObject {
    var channels: [Channel]? { get set }
    var programItems: [[ProgramItem]]? { get set }

    var router: RouterProtocol? { get set }
    var interactor: ChannelsInteractorProtocol? { get set }

    func getChannels(view: ChannelsViewProtocol)
}

final class ChannelsPresenter: ChannelsViewPresenterProtocol {
    //MARK: - Public Properties

    var channels: [Channel]?
    var programItems: [[ProgramItem]]?

    var router: RouterProtocol?
    var interactor: ChannelsInteractorProtocol?
    weak var view: ChannelsViewProtocol?

    //MARK: - Init

    init(router: RouterProtocol, interactor: ChannelsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }

    //MARK: - Public Methods

    func getChannels(view: ChannelsViewProtocol) {
        interactor?.getProgramData { [weak self] channels, programItems in
            self?.channels = channels
            self?.programItems = programItems
            view.updateData()
        }
    }
}
