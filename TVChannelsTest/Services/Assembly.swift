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
        let view = ChannelsViewController()
        let channelsAPIService = ChannelsAPIService()
        let interactor = ChannelsInteractor(channelsAPIService: channelsAPIService)
        let presenter = ChannelsPresenter(router: router, interactor: interactor)
        view.presenter = presenter
        return view
    }

    func createDetailsModule(channelName: String, programItem: ProgramItem) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(channelName: channelName, programItem: programItem)
        view.presenter = presenter
        return view
    }
}
