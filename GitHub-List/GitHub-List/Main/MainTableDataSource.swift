//
//  MainTableDataSource.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

enum RepoCellType {
    case repoCell(Repository)
    case skeleton
}

protocol CatcherMainTableDataSource: AnyObject {
    func didSelectListItem(_ repo: Repository)
    func loadData()
}

class MainTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var catcherController: CatcherMainTableDataSource?
    
    private var tableView: UITableView
    
    var repos: [Repository] = []
    
    var filteredRepositories = [Repository]()
    
    var cellType: [RepoCellType] = [.skeleton, .skeleton, .skeleton, .skeleton]
    
    var query: String = ""
    
    var isLoading = false
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredRepositories.count > 0 {
            return filteredRepositories.count
        }
        return cellType.count
    }
    
    func updateData(repos: [Repository]) {
        var cells: [RepoCellType] = []
        for item in repos {
            cells.append(.repoCell(item))
        }
        self.repos.append(contentsOf: repos)
        cellType.append(contentsOf: cells)
        print("load data finished")
        tableView.reloadData()
        isLoading = false
    }
    
    func setCells(repos: [Repository]) {
        
        cellType.removeAll()
        
        self.repos = repos
        
        if repos.count > 0 {
            for item in repos {
                cellType.append(.repoCell(item))
            }
        }
        tableView.reloadData()
    }
    
    func resetFilter() {
        filteredRepositories.removeAll()
        setCells(repos: repos)
    }
    
    func filterForSearchText(searchText: String) {
        filteredRepositories = repos.filter { repo in
            let searchTextMatch = repo.name.lowercased().contains(searchText.lowercased())
            return searchTextMatch
        }
        
        if filteredRepositories.count > 0 {
            cellType.removeAll()
            for item in filteredRepositories {
                cellType.append(.repoCell(item))
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType[indexPath.row] {
            case let .repoCell(repo):
                let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath as IndexPath) as! RepositoryCell
                cell.configureWith(repo: repo)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                return cell
            case .skeleton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SkeletonCell", for: indexPath as IndexPath) as! SkeletonCell
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard repos.count != 0 else { return }
        catcherController?.didSelectListItem(repos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellType.count - 4 {
            if !isLoading {
                isLoading = true
                print("load data")
                catcherController?.loadData()
            }
        }
    }
}
