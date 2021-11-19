// Channel.swift
// Copyright © Dmi3. All rights reserved.

import SwiftyJSON

final class Channel {
    var orderNum = Int()
    var accessNum = Int()
    var callSign = String()
    var id = Int()

    convenience init?(json: JSON) {
        self.init()

        orderNum = json["orderNum"].intValue
        accessNum = json["accessNum"].intValue
        callSign = json["CallSign"].stringValue
        id = json["id"].intValue
    }
}
