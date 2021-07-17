//
//  SpaceXLaunchTableViewCell.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import UIKit
import Kingfisher

class SpaceXLaunchTableViewCell: UITableViewCell {
    
    weak var viewModel: SpaceXLaunchViewModel?
    
    var launch: SpaceXLaunch? {
        didSet {
            if let imageURLString = launch?.links?.patch?.small {
                missionImageView.kf.setImage(with: URL(string: imageURLString))
            }
            statsView.launch = launch
            successImageView.image = UIImage(systemName: launch?.success == true ? "checkmark" : "xmark")
            successImageView.tintColor = launch?.success == true ? R.color.primaryAccent() : R.color.red()
            
            getRocket()
        }
    }
    
    private lazy var hStackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.alignment = .top
        s.distribution = .fill
        s.spacing = 8
        s.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    private lazy var missionImageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.heightAnchor.constraint(equalToConstant: 44).isActive = true
        i.widthAnchor.constraint(equalTo: i.heightAnchor).isActive = true
        return i
    }()
    
    private lazy var successImageView: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "checkmark"))
        i.tintColor = R.color.primaryAccent()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.heightAnchor.constraint(equalToConstant: 44).isActive = true
        i.widthAnchor.constraint(equalTo: i.heightAnchor).isActive = true
        return i
    }()
    
    private lazy var statsView: SpaceXLaunchStatsView = {
        let s = SpaceXLaunchStatsView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(hStackView)
        hStackView.pinToParentView()
        hStackView.addArrangedSubview(missionImageView)
        hStackView.addArrangedSubview(statsView)
        hStackView.addArrangedSubview(successImageView)
    }
    
    func getRocket() {
        statsView.rocket = nil
        guard let id = launch?.rocket else { return }
        viewModel?.getRocket(id, completion: { [weak self] rocket in
            DispatchQueue.main.async {
                if rocket.id == id {
                    self?.statsView.rocket = rocket
                }
            }
        })
    }
}
