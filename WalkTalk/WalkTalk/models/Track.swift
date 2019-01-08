//
//  Track.swift
//  WalkTalk
//
//  Created by Josh Kneedler on 1/8/19.
//  Copyright © 2019 Josh Kneedler. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Track: Object, Decodable {
    @objc dynamic var id: String?
    @objc dynamic var trackOrder: String?
    @objc dynamic var artist: String?
    @objc dynamic var song: String?
    @objc dynamic var fileName: String?
    @objc dynamic var vinylFile: String?
    @objc dynamic var light: String?
    @objc dynamic var windPower: String?
    @objc dynamic var windDirection: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case trackOrder
        case artist
        case song
        case fileName
        case vinylFile
        case light
        case windPower
        case windDirection
    }
}
