//
//  SpaceXLaunchFiltersViewController.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import UIKit

class SpaceXLaunchFiltersViewController: UIViewController {
    
    weak var viewModel: SpaceXLaunchViewModel? {
        didSet {
            if let index = SpaceXMissionSuccessFilter.allCases.firstIndex(where: { $0 == viewModel?.filters.success }) {
                successSegment.selectedSegmentIndex = index
            }
            ascendingSwitch.isOn = viewModel?.filters.ascending == true
            
            if let year = viewModel?.filters.year {
                yearPickerButton.setTitle("\(year)", for: .normal)
            } else {
                yearPickerButton.setTitle("ALL_YEARS".localised(), for: .normal)
            }
            filters.ascending = viewModel?.filters.ascending == true
            filters.success = viewModel?.filters.success ?? .all
            filters.year = viewModel?.filters.year
        }
    }
    
    private var filters = SpaceXLaunchFilters()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 16
        s.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    private lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var yearPickerButton: UIButton = {
        let b = UIButton()
        b.setTitle("ALL_YEARS".localised(), for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        b.setTitleColor(R.color.primaryAccent(), for: .normal)
        b.backgroundColor = R.color.secondaryBackground()
        b.layer.cornerRadius = 8
        b.layer.cornerCurve = .continuous
        b.widthAnchor.constraint(equalToConstant: 120).isActive = true
        b.addAction(UIAction(handler: { _ in
            self.showAvailableYears()
        }), for: .touchUpInside)
        return b
    }()
    
    private lazy var successSegment: UISegmentedControl = {
        let items = SpaceXMissionSuccessFilter.allCases.compactMap({ $0.rawValue.localised() })
        let s = UISegmentedControl(items: items)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.selectedSegmentIndex = 0
        s.tintColor = R.color.primaryFont()
        s.addAction(UIAction(handler: { _ in
            self.filters.success = SpaceXMissionSuccessFilter.allCases[s.selectedSegmentIndex]
        }), for: .valueChanged)
        return s
    }()
    
    private lazy var ascendingSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.onTintColor = R.color.primaryAccent()
        s.addAction(UIAction(handler: { _ in
            self.filters.ascending = s.isOn
        }), for: .valueChanged)
        return s
    }()
    
    private lazy var updateButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("UPDATE_FILTERS".localised(), for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        b.setTitleColor(R.color.primaryAccent(), for: .normal)
        b.backgroundColor = R.color.secondaryBackground()
        b.layer.cornerRadius = 8
        b.layer.cornerCurve = .continuous
        b.addAction(UIAction(handler: { _ in
            self.updateFiltersAndClose()
        }), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = R.color.primaryBackground()
        
        view.addSubview(scrollView)
        scrollView.pinToParentView()
        scrollView.addSubview(stackView)
        stackView.pinToParentView()
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(createFilterLine("YEAR".localised(), view: yearPickerButton))
        stackView.addArrangedSubview(createFilterLine("SUCCESSFUL_LAUNCH".localised(), view: successSegment))
        stackView.addArrangedSubview(createFilterLine("ASCENDING_DATE".localised(), view: ascendingSwitch))
        stackView.addArrangedSubview(updateButton)
    }
    
    func createFilterLine(_ title: String, view: UIView) -> UIView {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 8

        let t = UILabel()
        t.textColor = R.color.primaryFont()
        t.font = .systemFont(ofSize: 14, weight: .bold)
        t.text = title
        s.addArrangedSubview(t)
        
        s.addArrangedSubview(view)
        return s
    }
    
    func showAvailableYears() {
        guard let viewModel = viewModel else { return }
        let alert = UIAlertController(title: "SpaceX", message: "SELECT_YEAR_MESSAGE".localised(), preferredStyle: .alert)
        let yearsArray: [Int] = viewModel.launchData.compactMap({
            guard let date = $0.date else { return nil }
            let year = Calendar.current.component(.year, from: date)
            return year
        })
        let years = Set(yearsArray)
        alert.addAction(UIAlertAction(title: "ALL_YEARS".localised(), style: .default, handler: { _ in
            self.filters.year = nil
            self.yearPickerButton.setTitle("ALL_YEARS".localised(), for: .normal)
        }))
        years.forEach({ year in
            alert.addAction(UIAlertAction(title: "\(year)", style: .default, handler: { _ in
                self.filters.year = year
                self.yearPickerButton.setTitle("\(year)", for: .normal)
            }))
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateFiltersAndClose() {
        viewModel?.applyFilters(newFilters: filters)
        dismiss(animated: true, completion: nil)
    }
}
