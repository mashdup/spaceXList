//
//  String+Localisable.swift
//  SpaceX
//
//  Created by Dillon Hoa on 16/07/2021.
//

import Foundation

extension String {
    
    func localised() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
