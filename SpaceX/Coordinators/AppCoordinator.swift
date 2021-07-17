//
//  AppCoordinator.swift
//  SpaceX
//
//  Created by Dillon Hoa on 16/07/2021.
//

import UIKit

class AppCoordinator: NSObject {
    weak var window: UIWindow?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
//        self.navigationController.delegate = self
//        self.navigationController.navigationBar.barTintColor = Colour.navigation
//        self.navigationController.navigationBar.titleTextAttributes = [
//            .font: UIFont.courrier(of: 24, weight: .bold) ?? .systemFont(ofSize: 24),
//            .foregroundColor: Colour.navigationTint
//        ]
//        self.navigationController.navigationBar.layer.shadowColor = UIColor.black.cgColor
//        self.navigationController.navigationBar.layer.shadowRadius = 4
//        self.navigationController.navigationBar.layer.shadowOpacity = 0.2
//        self.navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func start() {
        let vc = InitialViewController()
        vc.coordinator = self
        let vm = InitialViewModel()
        vc.viewModel = vm
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.setViewControllers([vc], animated: false)
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func showMainScreen() {
        let vc = SpaceXLaunchViewController()
        let vm = SpaceXLaunchViewModel()
        vc.coordinator = SpaceXLaunchCoordinator(navigationController: navigationController)
        vc.viewModel = vm
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .fade
        self.navigationController.view.layer.add(transition, forKey: nil)
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.setViewControllers([vc], animated: false)
    }
}
