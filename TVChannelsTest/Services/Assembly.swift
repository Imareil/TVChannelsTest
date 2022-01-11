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
        let view = ChannelsViewController(presenter: presenter)
        view.title = Constants.channelcVCTitle
        return view
    }

    func createDetailsModule(channelName: String, programItem: ProgramItem) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(channelName: channelName, programItem: programItem)
        view.presenter = presenter
        return view
    }
}
