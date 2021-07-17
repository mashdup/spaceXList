//
//  InitialViewController.swift
//  SpaceX
//
//  Created by Dillon Hoa on 16/07/2021.
//

import UIKit

class InitialViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    var viewModel: InitialViewModel?
    
    private lazy var launchLogoImageView: UIImageView = {
        let i = UIImageView(image: R.image.launchLogo())
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = R.color.primaryBackground()
        view.addSubview(launchLogoImageView)
        
        NSLayoutConstraint.activate([
            launchLogoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            launchLogoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            launchLogoImageView.widthAnchor.constraint(equalToConstant: 240)
        ])
        
        // For now we just show the main screen
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.showMainScreen()
        })
    }
    
    func showMainScreen() {
        coordinator?.showMainScreen()
    }
}
