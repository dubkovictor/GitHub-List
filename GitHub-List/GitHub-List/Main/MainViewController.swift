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
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var weekBtn: UIButton!
    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(self)
        
        self.title = "Details"
        
        setupTableView()
        presenter.fetcher()
        
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        
        monthBtn.addTarget(self, action: #selector(monthBtnDidTap), for: .touchUpInside)
        weekBtn.addTarget(self, action: #selector(weekBtnDidtap), for: .touchUpInside)
        dayBtn.addTarget(self, action: #selector(dayBtnDidTap), for: .touchUpInside)
        favoriteBtn.addTarget(self, action: #selector(favoriteBtnDidTap), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
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
    
    @objc func monthBtnDidTap() {
        presenter.lastMonthSelected()
    }
    
    @objc func weekBtnDidtap() {
        presenter.lastWeekSelected()
    }
    
    @objc func dayBtnDidTap() {
        presenter.lastDaySelected()
    }
    
    @objc func favoriteBtnDidTap() {
        coordinator?.openFavoriteVC()
    }
}

extension MainViewController: MainViewDelegate {
    func showRepos(repos: [Repository]) {
        if mainTableDataSource.repos.count > 0 {
            mainTableDataSource.updateData(repos: repos)
        } else {
            mainTableDataSource.setCells(repos: repos)
        }
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
        mainTableDataSource.resetFilter()
        return true
    }
}

extension MainViewController: CatcherMainTableDataSource {
    
    func didSelectListItem(_ repo: Repository) {
        coordinator?.openDetailsVC(repo: repo, isSaved: false)
    }
    
    func loadData() {
        presenter.loadData()
    }
    
}
