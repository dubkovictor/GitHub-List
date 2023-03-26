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
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(self)
        
        setupTableView()
        presenter.fetcher()
        
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        
//        searchBar.tintColor = .black
//        searchBar.subviews[0].subviews.compactMap() { $0 as? UITextField }.first?.tintColor = UIColor.red
//        
//        searchBar.setImage(UIImage(), for: .search, state: .normal)
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
        if show {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
    }
    
    func showError(message: String) {
        
    }
}

extension MainViewController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            mainTableDataSource.filterForSearchText(searchText: searchText)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        mainTableDataSource.filterForSearchText(searchText: "")
        return true
    }
}

extension MainViewController: CatcherMainTableDataSource {
    func didSelectListItem(_ repo: Repository) {
        coordinator?.openDetailsVC(repo: repo)
    }
    
}
