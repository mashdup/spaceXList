//
//  MockLaunchService.swift
//  SpaceXTests
//
//  Created by Dillon Hoa on 25/02/2022.
//

import Foundation
@testable import SpaceX

class MockLaunchService: LaunchService {
    func getCompanyInfo(_ completion: @escaping ((Result<SpaceXCompanyInfo, Error>) -> Void)) {
        completion(.success(SpaceXCompanyInfo(headquarters: Headquarters(address: "123", city: "City", state: "State"), links: nil, name: "TestCompany", founder: "Me", founded: 1985, employees: 1000, vehicles: 1000, launchSites: 100, testSites: 100, ceo: "Me", cto: "Me", coo: "Me", ctoPropulsion: "Me", valuation: 100000, summary: "HelloWorld", id: "1")))
    }
    
    func getLaunches(_ completion: @escaping ((Result<[SpaceXLaunch], Error>) -> Void)) {
        completion(.success([
        SpaceXLaunch(name: "Test", timeStamp: 123456789, rocket: "TestRocket", type: "TestType", links: nil, success: true)
        ]))
    }
    
    func getRocket(_ id: String, completion: @escaping ((Result<SpaceXRocket, Error>) -> Void)) {
        completion(.success(SpaceXRocket(id: "1", name: "TestRocket", type: "TestType")))
    }
    
    
}
