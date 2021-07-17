//
//  SpaceXLaunchViewController.swift
//  SpaceX
//
//  Created by Dillon Hoa on 16/07/2021.
//

import UIKit

class SpaceXLaunchViewController: UIViewController {
    
    var coordinator: SpaceXLaunchCoordinator?
    
    var viewModel: SpaceXLaunchViewModel? {
        didSet {
            bindViewModel()
            reloadData()
        }
    }
    
    private lazy var navigationImageView: UIImageView = {
        let i = UIImageView(image: R.image.launchLogo())
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return i
    }()
    
    private lazy var filterButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        b.tintColor = R.color.primaryAccent()
        b.addAction(UIAction(handler: { _ in
            self.coordinator?.showFilters(viewModel: self.viewModel)
        }), for: .touchUpInside)
        return b
    }()
    
    private lazy var headerContentView: SpaceXLaunchTableHeaderView = {
        let h = SpaceXLaunchTableHeaderView()
        return h
    }()
    
    private lazy var tableHeaderView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(headerContentView)
        headerContentView.pinToParentView()
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.register(SpaceXLaunchSectionHeaderView.self,
                   forHeaderFooterViewReuseIdentifier: SpaceXLaunchSectionHeaderView.self.description())
        t.register(SpaceXLaunchTableViewCell.self, forCellReuseIdentifier: SpaceXLaunchTableViewCell.self.description())
        t.dataSource = self
        t.delegate = self
        t.backgroundColor = .clear
        t.refreshControl = refreshControl
        return t
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addAction(UIAction(handler: { _ in
            self.reloadData()
        }), for: .valueChanged)
        return r
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.tableHeaderView?.layoutIfNeeded()
        tableView.tableHeaderView = tableView.tableHeaderView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setup() {
        navigationItem.titleView = navigationImageView
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
        view.backgroundColor = R.color.primaryBackground()
        
        view.addSubview(tableView)
        tableView.pinToParentView()
        
        tableView.tableHeaderView = tableHeaderView
        NSLayoutConstraint.activate([
            tableHeaderView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel?.didUpdateCompanyInfo = { [weak self] in
            DispatchQueue.main.async {
                self?.headerContentView.companyInfo = self?.viewModel?.companyInfo
                self?.tableView.tableHeaderView?.layoutIfNeeded()
                self?.tableView.tableHeaderView = self?.tableView.tableHeaderView
            }
        }
        
        viewModel?.didUpdateLaunches = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    func reloadData() {
        viewModel?.getLaunches()
        viewModel?.getCompanyInfo()
    }
    
    func showLaunchActions(_ launch: SpaceXLaunch, sourceView: UIView? = nil) {
        let alert = UIAlertController(title: "SpaceX", message: "WHAT_DO_YOU_LIKE_TO_DO".localised(), preferredStyle: .actionSheet)
        if let article = launch.links?.article {
            
            alert.addAction(UIAlertAction(title: "VIEW_ARTICLE".localised(), style: .default, handler: { _ in
                self.coordinator?.presentWebURL(URL(string: article))
            }))
        }
        
        if let wikipedia = launch.links?.wikipedia {
            alert.addAction(UIAlertAction(title: "LOOKUP_WIKIPEDIA".localised(), style: .default, handler: { _ in
                self.coordinator?.presentWebURL(URL(string: wikipedia))
            }))
            
        }
        
        if let video = launch.links?.webcast {
            
            alert.addAction(UIAlertAction(title: "CHECKOUT_VIDEOS".localised(), style: .default, handler: { _ in
                self.coordinator?.presentWebURL(URL(string: video))
            }))
        }
        
        alert.addAction(UIAlertAction(title: "CANCEL".localised(), style: .cancel, handler: nil))
        alert.popoverPresentationController?.sourceView = sourceView
        self.present(alert, animated: true, completion: nil)
    }
}

extension SpaceXLaunchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let h = SpaceXLaunchSectionHeaderView()
        return h
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let launch = viewModel?.launches[indexPath.row] else { return }
        showLaunchActions(launch, sourceView: tableView.cellForRow(at: indexPath))
    }
}

extension SpaceXLaunchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.launches.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpaceXLaunchTableViewCell.self.description(), for: indexPath) as? SpaceXLaunchTableViewCell else  {
            return SpaceXLaunchTableViewCell()
        }
        if let launch = viewModel?.launches[indexPath.row] {
            cell.viewModel = viewModel
            cell.launch = launch
        }
        return cell
    }
    
    
}
