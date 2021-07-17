//
//  PopUpViewController.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import UIKit

class PopUpViewController: UIActivityViewController {

    private let controller: UIViewController?

    required init(controller: UIViewController) {
        self.controller = controller
        super.init(activityItems: [], applicationActivities: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.subviews.forEach({ $0.removeFromSuperview()})

        guard let controller = controller else { return }
        self.addChild(controller)
        self.view.addSubview(controller.view)
    }

}
