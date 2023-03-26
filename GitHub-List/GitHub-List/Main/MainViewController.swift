//
//  ViewController.swift
//  GitHub-List
//
//  Created by Victor on 24.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    let presenter = MainPresenter()
    
    private var viewDelegate: MainViewDelegate!
    
    private var mainTableDataSource: MainTableDataSource!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(self)
        
        setupTableView()
        presenter.fetcher()
    }
    
    func setupTableView() {
        mainTableDataSource = MainTableDataSource(tableView: tableView)
        mainTableDataSource.catcherController = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = mainTableDataSource
        tableView.delegate = mainTableDataSource
        
        tableView.register(UINib(nibName: "SkeletonCell", bundle: nil), forCellReuseIdentifier: "SkeletonCell")
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }


}

extension MainViewController: MainViewDelegate {
    func showRepos(repos: [Repository]) {
        mainTableDataSource.setCells(repos: repos)
    }
    
    func showProgress(show: Bool) {
        
    }
    
    func showError(message: String) {
        
    }
    
    
}

extension MainViewController: CatcherMainTableDataSource {
    func didSelectListItem(_ index: IndexPath) {
        print(index)
    }
    
    
}
