// Assembly.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

protocol AssemblyProtocol {
    func createChannelsModule(router: RouterProtocol) -> UIViewController
    func createDetailsModule(channelName: String, programItem: ProgramItem)
        -> UIViewController
}

final class Assembly: AssemblyProtocol {
    func createChannelsModule(router: RouterProtocol) -> UIViewController {
        let channelsAPIService = ChannelsAPIService()
        let interactor = ChannelsInteractor(channelsAPIService: channelsAPIService)
        let presenter = ChannelsPresenter(router: router, interactor: interactor)
        let viewController = ChannelsViewController(presenter: presenter)
        return viewController
    }

    func createDetailsModule(channelName: String, programItem: ProgramItem) -> UIViewController {
        let presenter = DetailsPresenter(channelName: channelName, programItem: programItem)
        let view = DetailsViewController(presenter: presenter)
        return view
    }
}
