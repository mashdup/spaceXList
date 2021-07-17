//
//  SpaceXLaunchSectionHeaderView.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import UIKit

class SpaceXLaunchSectionHeaderView: UITableViewHeaderFooterView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 14, weight: .bold)
        l.textColor = R.color.primaryFont()
        l.text = "LAUNCHES".localised()
        return l
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.backgroundColor = R.color.primaryBackground()
        contentView.addSubview(titleLabel)
        titleLabel.pinToParentView(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
}
