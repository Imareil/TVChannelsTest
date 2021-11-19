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
    func showDetails(channelNumber: Int, itemNumber: Int)
}

final class ChannelsPresenter: ChannelsViewPresenterProtocol {
    // MARK: - Public Properties

    var channels: [Channel]?
    var programItems: [[ProgramItem]]?

    var router: RouterProtocol?
    var interactor: ChannelsInteractorProtocol?
    weak var view: ChannelsViewProtocol?

    // MARK: - Init

    init(router: RouterProtocol, interactor: ChannelsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }

    // MARK: - Public Methods

    func getChannels(view: ChannelsViewProtocol) {
        interactor?.getProgramData { [weak self] channels, programItems in
            self?.channels = channels
            self?.programItems = programItems
            view.updateData()
        }
    }

    func showDetails(channelNumber: Int, itemNumber: Int) {
        guard let channelName = channels?[channelNumber].callSign,
              let programName = programItems?[channelNumber][itemNumber].name,
              let programStartTime = programItems?[channelNumber][itemNumber].startTime,
              let programLength = programItems?[channelNumber][itemNumber].length,
              let startTime = interactor?.convertTime(isoTime: programStartTime)[1]
        else { return }

        guard let programItem = ProgramItem(startTime: startTime, length: programLength, name: programName)
        else { return }
        router?.showDetails(channelName: channelName, programItem: programItem)
    }
}
