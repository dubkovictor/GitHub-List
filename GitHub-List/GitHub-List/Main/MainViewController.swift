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
    
    private var mode: Mode = .month
    
    private var isSearchBarActive = false
    
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
        monthBtnDidTap()
        
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
        mode = .month
        presenter.currentRange = .month
        setupSelection()
        presenter.loadMonth()
        
        if isSearchBarActive {
            mainTableDataSource.resetFilter()
            searchBarEndEditing()
        }
        
        mainTableDataSource.showMonth()
    }
    
    @objc func weekBtnDidtap() {
        mode = .week
        presenter.currentRange = .week
        setupSelection()
        presenter.loadWeek()
        
        if isSearchBarActive {
            mainTableDataSource.resetFilter()
            searchBarEndEditing()
        }
        
        mainTableDataSource.showWeek()
        
    }
    
    @objc func dayBtnDidTap() {
        mode = .day
        presenter.currentRange = .day
        setupSelection()
        presenter.loadDay()
        
        if isSearchBarActive {
            mainTableDataSource.resetFilter()
            searchBarEndEditing()
        }
        
        mainTableDataSource.showDay()
    }
    
    @objc func favoriteBtnDidTap() {
        coordinator?.openFavoriteVC()
    }
    
    func setupSelection() {
        switch mode {
            case .month:
                monthBtn.isSelected = true
                weekBtn.isSelected = false
                dayBtn.isSelected = false
            case .week:
                monthBtn.isSelected = false
                weekBtn.isSelected = true
                dayBtn.isSelected = false
            case .day:
                monthBtn.isSelected = false
                weekBtn.isSelected = false
                dayBtn.isSelected = true
        }
    }
    
    func searchBarEndEditing() {
        isSearchBarActive = false
        searchBar.endEditing(true)
        searchBar.text = ""
    }
}

extension MainViewController: MainViewDelegate {
    func showRepos(repos: [Repository]) {
        switch mode {
            case .month:
                presenter.monthRepos = repos
                mainTableDataSource.setMonthCells(repos: repos)
            case .week:
                presenter.weekRepos = repos
                mainTableDataSource.setWeekCells(repos: repos)
            case .day:
                presenter.dayRepos = repos
                mainTableDataSource.setDayCells(repos: repos)
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
        let dialogMessage = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.presenter.fetcher()
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            mainTableDataSource.filterForSearchText(searchText: searchText)
        }
        
        isSearchBarActive = true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        mainTableDataSource.resetFilter()
        isSearchBarActive = false
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
