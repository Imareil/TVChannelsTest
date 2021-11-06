// ProgramItem.swift
// Copyright © Dmi3. All rights reserved.

import SwiftyJSON

final class ProgramItem {
    var startTime = String()
    var id = Int()
    var channelID = Int()
    var length = Int()
    var name = String()

    convenience init?(json: JSON) {
        self.init()

        startTime = json["startTime"].stringValue
        id = json["recentAirTime"]["id"].intValue
        channelID = json["recentAirTime"]["channelID"].intValue
        length = json["length"].intValue
        name = json["name"].stringValue
    }
}
