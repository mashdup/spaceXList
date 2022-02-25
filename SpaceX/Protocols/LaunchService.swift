//
//  LaunchService.swift
//  SpaceX
//
//  Created by Dillon Hoa on 25/02/2022.
//

import Foundation

protocol LaunchService {
    func getCompanyInfo(_ completion: @escaping ((Swift.Result<SpaceXCompanyInfo, Error>) -> Void))
    func getLaunches(_ completion: @escaping ((Swift.Result<[SpaceXLaunch], Error>) -> Void))
    func getRocket(_ id: String, completion: @escaping ((Swift.Result<SpaceXRocket, Error>) -> Void))
}
