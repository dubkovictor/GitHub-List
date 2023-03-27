//
//  FavoriteViewController.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import UIKit


class FavoriteViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    let presenter = FavoritePresenter()
    
    private var viewDelegate: FavoriteViewDelegate!
    
    private var favoriteTableDataSource: FavoriteTableDataSource!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(self)
        
        self.title = "Favorite"
        
        setupTableView()
        
        presenter.fetchData()
    }
    
    func setupTableView() {
        favoriteTableDataSource = FavoriteTableDataSource(tableView: tableView)
        favoriteTableDataSource.catcherController = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = favoriteTableDataSource
        tableView.delegate = favoriteTableDataSource
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension FavoriteViewController: FavoriteViewDelegate {
    func showRepos(repos: [RepositoryObject]) {
        print(repos)
        favoriteTableDataSource.setCells(repos: repos)
    }
}

extension FavoriteViewController: CatcherFavoriteTableDataSource {
    
    func didSelectListItem(_ repo: Repository) {
        coordinator?.openDetailsVC(repo: repo, isSaved: true)
    }
    
    func remove(repo: RepositoryObject) {
        presenter.remove(repo: repo)
    }
}
