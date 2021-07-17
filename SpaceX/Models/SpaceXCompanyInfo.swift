//
//  SpaceXCompanyInfo.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import Foundation

struct SpaceXCompanyInfo: Codable {
    var headquarters: Headquarters?
    var links: SocialLinks?
    var name: String?
    var founder: String?
    var founded: Int?
    var employees: Int?
    var vehicles: Int?
    var launchSites: Int?
    var testSites: Int?
    var ceo: String?
    var cto: String?
    var coo: String?
    var ctoPropulsion: String?
    var valuation: Int?
    var summary: String?
    var id: String?
    
    enum CodingKeys: String, CodingKey {
        
        case headquarters
        case links
        case name
        case founder
        case founded
        case employees
        case vehicles
        case launchSites = "launch_sites"
        case testSites = "test_sites"
        case ceo
        case cto
        case coo
        case ctoPropulsion = "cto_propulsion"
        case valuation
        case summary
        case id
    }
}

struct Headquarters: Codable {
    var address: String?
    var city: String?
    var state: String?
}

struct SocialLinks: Codable {
    var website: String?
    var flickr: String?
    var twitter: String?
    var elonTwitter: String?
    
    enum CodingKeys: String, CodingKey {
        case website
        case flickr
        case twitter
        case elonTwitter = "elon_twitter"
    }
}
