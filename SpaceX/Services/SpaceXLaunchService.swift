//
//  SpaceXLaunchService.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import Foundation
class SpaceXLaunchService {
    func getCompanyInfo(_ completion: @escaping ((Swift.Result<SpaceXCompanyInfo, Error>) -> Void)) {
        NetworkManager.default.request(SpaceXCompanyInfo.self, method: .get, path: "company", completion: { result in
            completion(result)
        })
    }
    
    func getLaunches(_ completion: @escaping ((Swift.Result<[SpaceXLaunch], Error>) -> Void)) {
        NetworkManager.default.request([SpaceXLaunch].self, method: .get, path: "launches", completion: { result in
            completion(result)
        })
    }
    
    func getRocket(_ id: String, completion: @escaping ((Swift.Result<SpaceXRocket, Error>) -> Void)) {
        NetworkManager.default.request(SpaceXRocket.self, method: .get, path: "rockets/\(id)", completion: { result in
            completion(result)
        })
    }
}
