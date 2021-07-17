//
//  SpaceXLaunchCoordinator.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import Foundation

class SpaceXLaunchCoordinator: AppCoordinator {
    func showFilters(viewModel: SpaceXLaunchViewModel?) {
        let vc = SpaceXLaunchFiltersViewController()
        vc.viewModel = viewModel
        let pop = PopUpViewController(controller: vc)
        
        navigationController.present(pop, animated: true, completion: nil)
    }
}
