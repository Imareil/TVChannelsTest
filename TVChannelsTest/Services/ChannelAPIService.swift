// ChannelAPIService.swift
// Copyright © Dmi3. All rights reserved.

import Alamofire
import SwiftyJSON
import UIKit

protocol ChannelsAPIProtocol {
    func fetchChannelsData(url: String, complition: @escaping (_ channels: [Channel]) -> ())
    func fetchProgramItems(url: String, complition: @escaping ([ProgramItem]) -> ())
}

final class ChannelsAPIService: ChannelsAPIProtocol {
    func fetchChannelsData(url: String, complition: @escaping ([Channel]) -> ()) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                let channels = json.arrayValue.compactMap { Channel(json: $0) }
                complition(channels)

            } catch {
                print(error)
            }
        }
    }

    func fetchProgramItems(url: String, complition: @escaping ([ProgramItem]) -> ()) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                let channels = json.arrayValue.compactMap { ProgramItem(json: $0) }
                complition(channels)

            } catch {
                print(error)
            }
        }
    }
}
