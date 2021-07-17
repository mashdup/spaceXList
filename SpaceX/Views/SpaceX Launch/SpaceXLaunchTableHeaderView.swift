//
//  SpaceXLaunchTableHeaderView.swift
//  SpaceX
//
//  Created by Dillon Hoa on 16/07/2021.
//

import UIKit

class SpaceXLaunchTableHeaderView: UITableViewHeaderFooterView {
    
    var companyInfo: SpaceXCompanyInfo? {
        didSet {
            let nf = NumberFormatter()
            nf.numberStyle = .currency
            nf.locale = Locale(identifier: "en_US")
            guard let name = companyInfo?.name,
                  let founder = companyInfo?.founder,
                  let year = companyInfo?.founded,
                  let employees = companyInfo?.employees,
                  let sites = companyInfo?.launchSites,
                  let valuation = companyInfo?.valuation,
                  let valuationString = nf.string(from: NSNumber(value: valuation)) else { return }
            
            let content = String(format:"COMPANY_INFO_FORMAT".localised(),
                                       name,
                                       founder,
                                       "\(year)",
                                       "\(employees)",
                                       "\(sites)",
                                       valuationString)
            self.contentLabel.text = content
            
        }
    }
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 8
        s.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 14, weight: .bold)
        l.textColor = R.color.primaryFont()
        l.text = "COMPANY".localised()
        return l
    }()
    
    private lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = R.color.primaryFont()
        l.numberOfLines = 0
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
        addSubview(stackView)
        stackView.pinToParentView()
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
    }
}
