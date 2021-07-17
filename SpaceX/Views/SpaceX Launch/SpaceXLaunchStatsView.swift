//
//  SpaceXLaunchStatsView.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import UIKit

class SpaceXLaunchStatsView: UIView {
    
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
    
    var launch: SpaceXLaunch? {
        didSet {
            missionLabel.text = launch?.name
            if let date = launch?.date {
                dateLabel.text = dateFormatter.string(from: date)
            }
            if let timeStamp = launch?.timeStamp {
                let seconds = timeStamp - Int(Date().timeIntervalSince1970)
                let days = seconds/84600
                daysTitleLabel.text = days > 0 ? "DAYS_FROM_NOW".localised() : "DAYS_SINCE_NOW".localised() + ":"
                daysLabel.text = "\(days > 0 ? "+" : "")\(days)"
            }
        }
    }
    
    var rocket: SpaceXRocket? {
        didSet {
            guard let rocket = rocket, let name = rocket.name, let type = rocket.type else {
                rocketLabel.text = "GETTING_ROCKET".localised()
                return
            }
            rocketLabel.text = "\(name) / \(type)"
        }
    }
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 8
        return s
    }()
    
    private lazy var missionLabel: UILabel = {
        let l = createLabel()
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var rocketLabel: UILabel = {
        let l = createLabel()
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var dateLabel: UILabel = {
        let l = createLabel()
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var daysTitleLabel: UILabel = {
        let l = createLabel(isTitle: true)
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var daysLabel: UILabel = {
        let l = createLabel()
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(stackView)
        stackView.pinToParentView()
        
        stackView.addArrangedSubview(createStatLine("MISSON".localised()+":", label: missionLabel))
        stackView.addArrangedSubview(createStatLine("DATE_TIME".localised()+":", label: dateLabel))
        stackView.addArrangedSubview(createStatLine("ROCKET".localised()+":", label: rocketLabel))
        stackView.addArrangedSubview(createStatLine("DAYS".localised(), titleLabel: daysTitleLabel, label: daysLabel))
    }
    
    func createLabel(isTitle: Bool = false) -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = R.color.primaryFont()
        l.font = .systemFont(ofSize: 14, weight: isTitle ? .regular : .bold)
        return l
    }
    
    func createStatLine(_ title: String, titleLabel: UILabel? = nil, label: UILabel) -> UIView {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.alignment = .top
        s.distribution = .fill
        s.spacing = 8
        if let titleLabel = titleLabel {
            titleLabel.text = title
            s.addArrangedSubview(titleLabel)
            
        } else {
            let t = createLabel(isTitle: true)
            t.text = title
            s.addArrangedSubview(t)
        }
        s.addArrangedSubview(label)
        return s
    }
}
