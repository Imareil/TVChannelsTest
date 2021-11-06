// ChannelsInteractor.swift
// Copyright © Dmi3. All rights reserved.

import Foundation

protocol ChannelsInteractorProtocol: AnyObject {
    func getProgramData()
}

final class ChannelsInteractor: ChannelsInteractorProtocol {
    var channelsAPIService: ChannelsAPIProtocol?
    weak var channelsPresenter: ChannelsViewPresenterProtocol?

    init(channelsAPIService: ChannelsAPIProtocol) {
        self.channelsAPIService = channelsAPIService
    }

    func getProgramData() {
        var channels: [Channel] = []
        var items: [ProgramItem] = []

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        getChannels { recievedChannels in
            channels = recievedChannels
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        getProgramItems { recievedItems in
            items = recievedItems
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .global()) {
            self.setTVProgram(channels: channels, items: items)
        }
    }

    private func getChannels(comlition: @escaping ([Channel]) -> ()) {
        let url = Hosts.channelsHost
        channelsAPIService?.fetchChannelsData(url: url, complition: { channels in
            comlition(channels)
        })
    }

    private func getProgramItems(complition: @escaping ([ProgramItem]) -> ()) {
        let url = Hosts.programItemsHost
        channelsAPIService?.fetchProgramItems(url: url, complition: { items in
            complition(items)
        })
    }

    private func setTVProgram(channels: [Channel], items: [ProgramItem]) {
        var tvProgram: [Int: [ProgramItem]] = [:]

        let channelIDs = channels.map(\.id)
        for id in channelIDs {
            let programs = items.filter { id == $0.channelID }
            tvProgram[id] = programs
        }
    }
}
