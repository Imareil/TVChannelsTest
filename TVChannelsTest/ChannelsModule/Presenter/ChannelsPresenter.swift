// ChannelsPresenter.swift
// Copyright © Dmi3. All rights reserved.

import Foundation

protocol ChannelsViewProtocol: AnyObject {
    func updateData(_ channels: [Channel])
}

protocol ChannelsViewPresenterProtocol: AnyObject {
    func getChannels(view: ChannelsViewProtocol)
}

final class ChannelsPresenter: ChannelsViewPresenterProtocol {
    var router: RouterProtocol?
    var interactor: ChannelsInteractorProtocol?
    weak var view: ChannelsViewProtocol?

    init(router: RouterProtocol, interactor: ChannelsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }

    func getChannels(view: ChannelsViewProtocol) {
        interactor?.getProgramData()
    }
}
