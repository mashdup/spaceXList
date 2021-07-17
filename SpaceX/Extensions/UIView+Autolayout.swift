//
//  UIView+Autolayout.swift
//  SpaceX
//
//  Created by Dillon Hoa on 16/07/2021.
//

import UIKit

extension UIView {
    func pinToParentView(_ inset: UIEdgeInsets = .zero) {
        if let parent = superview {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.topAnchor, constant: inset.top),
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: inset.left),
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -inset.right),
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -inset.bottom)
            ])
        }
    }
}
