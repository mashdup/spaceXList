//
//  SpaceXLaunch.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import Foundation

struct SpaceXLaunch: Codable {
    var name: String?
    var timeStamp: Int?
    var rocket: String?
    var type: String?
    var links: SpaceXLaunchLinks?
    var success: Bool?
    
    var date: Date? {
        guard let timeStamp = timeStamp else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(timeStamp))
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case timeStamp = "date_unix"
        case rocket
        case type
        case links
        case success
    }
}

struct SpaceXLaunchLinks: Codable {
    var patch: SpaceXLaunchPatchImage?
}

struct SpaceXLaunchPatchImage: Codable {
    var small: String?
    var large: String?
}
