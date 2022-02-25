//
//  SpaceXLaunchViewModel.swift
//  SpaceX
//
//  Created by Dillon Hoa on 16/07/2021.
//

import Foundation

class SpaceXLaunchViewModel {
    
    var service: LaunchService = SpaceXLaunchService()
    
    var didUpdateCompanyInfo: (() -> Void)?
    
    var didUpdateLaunches: (() -> Void)?
    
    var companyInfo: SpaceXCompanyInfo? {
        didSet {
            didUpdateCompanyInfo?()
        }
    }
    
    var launchData: [SpaceXLaunch] = [] {
        didSet {
            didUpdateLaunches?()
        }
    }
    
    var launches: [SpaceXLaunch] {
        var filterdData: [SpaceXLaunch] = []
        filterdData = launchData.filter({
            if let year = filters.year {
                guard let date = $0.date else { return false }
                let launchYear = Calendar.current.component(.year, from: date)
                if year != launchYear { return false }
            }
            switch filters.success {
            case .all:
                return true
            case .success:
                return $0.success == true
            case .failed:
                return $0.success == false
            }
        })
        let ordered = filterdData.sorted(by: {
            guard let firstDate = $0.date, let secondDate = $1.date else { return false }
            if filters.ascending {
                return firstDate < secondDate
            } else {
                return firstDate > secondDate
            }
        })
        return ordered
    }
    
    var rockets: [String: SpaceXRocket] = [: ]
    
    var filters = SpaceXLaunchFilters()
    
    func getCompanyInfo() {
        service.getCompanyInfo({ [weak self] result in
            switch result {
            case .success(let info):
                self?.companyInfo = info
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getLaunches() {
        service.getLaunches({ [weak self] result in
            switch result {
            case .success(let launches):
                self?.launchData = launches
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getRocket(_ id: String, completion: @escaping ((SpaceXRocket) -> Void)) {
        if let rocket = rockets[id] {
            completion(rocket)
            return
        }
        service.getRocket(id, completion: { [weak self] result in
            switch result {
            case .success(let rocket):
                self?.rockets[id] = rocket
                completion(rocket)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func applyFilters(newFilters: SpaceXLaunchFilters) {
        
        filters.ascending = newFilters.ascending
        filters.success = newFilters.success
        filters.year = newFilters.year
        didUpdateLaunches?()

    }
}

struct SpaceXLaunchFilters {
    var success: SpaceXMissionSuccessFilter = .all
    var ascending: Bool = true
    var year: Int?
}
