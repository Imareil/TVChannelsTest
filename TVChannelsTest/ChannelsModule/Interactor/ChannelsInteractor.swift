// ChannelsInteractor.swift
// Copyright © Dmi3. All rights reserved.

import Foundation

protocol ChannelsInteractorProtocol: AnyObject {
    var channelsAPIService: ChannelsAPIProtocol? { get set }
    func convertTime(isoTime: String) -> [String]
    func getProgramData(complition: @escaping ([Channel], [[ProgramItem]]) -> ())
}

final class ChannelsInteractor: ChannelsInteractorProtocol {
    // MARK: - Public Properties

    var channelsAPIService: ChannelsAPIProtocol?
    weak var channelsPresenter: ChannelsViewPresenterProtocol?

    // MARK: - Init

    init(channelsAPIService: ChannelsAPIProtocol) {
        self.channelsAPIService = channelsAPIService
    }

    // MARK: - Public Methods

    func getProgramData(complition: @escaping ([Channel], [[ProgramItem]]) -> ()) {
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
            self.setTVProgram(channels: channels, items: items) { channels, programItems in
                complition(channels, programItems)
            }
        }
    }

    func convertTime(isoTime: String) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        if let date = dateFormatter.date(from: isoTime) {
            let stringDate = "\(date)"
            return stringDate.components(separatedBy: " ")
        } else {
            return [""]
        }
    }

    // MARK: - Private Methods

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

    private func setTVProgram(
        channels: [Channel],
        items: [ProgramItem],
        complition: ([Channel], [[ProgramItem]]) -> ()
    ) {
        var programItems: [[ProgramItem]] = []

        let channelIDs = channels.map(\.id)
        for id in channelIDs {
            var programs = items
                .filter { id == $0.channelID }
                .filter { convertTime(isoTime: $0.startTime).first == Constants.currentDate }

            let checkedStartTime = checkstartTime(startTime: programs.first?.startTime ?? "")

            if checkedStartTime > 0 {
                guard let prItem = ProgramItem(
                    startTime: Constants.startTime,
                    length: checkedStartTime,
                    name: Constants.noProgram
                )
                else { return }
                programs.insert(prItem, at: 0)
            }

            programItems.append(programs)
        }

        complition(channels, programItems)
    }

    private func checkstartTime(startTime: String) -> Int {
        let convertedTime = convertTime(isoTime: startTime)
        let hours = separateTime(time: convertedTime[1])[0] - 1
        let minutes = separateTime(time: convertedTime[1])[1]

        let time = hours * 60 + minutes
        return time
    }

    private func separateTime(time: String) -> [Int] {
        let separatedTime = time.components(separatedBy: ":").compactMap(Int.init)
        return separatedTime
    }
}
