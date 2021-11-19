// DetailsPresenter.swift
// Copyright © Dmi3. All rights reserved.

import Foundation

protocol DetailsViewProtocol: AnyObject {
    func updateData(item: ProgramItem, channelName: String)
}

protocol DetailsViewPresenterProtocol: AnyObject {
    var channelName: String { get set }
    var programItem: ProgramItem { get set }

    func getData(view: DetailsViewProtocol)
}

final class DetailsPresenter: DetailsViewPresenterProtocol {
    var channelName: String
    var programItem: ProgramItem

    weak var view: DetailsViewProtocol?

    init(channelName: String, programItem: ProgramItem) {
        self.channelName = channelName
        self.programItem = programItem
    }

    func getData(view: DetailsViewProtocol) {
        view.updateData(item: programItem, channelName: channelName)
    }
}
