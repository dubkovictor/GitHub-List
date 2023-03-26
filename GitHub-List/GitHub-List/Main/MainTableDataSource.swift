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
}

class MainTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var catcherController: CatcherMainTableDataSource?
    
    private var tableView: UITableView
    
    var repos: [Repository] = []
    
    var filteredRepositories = [Repository]()
    
    var cellType: [RepoCellType] = [.skeleton, .skeleton, .skeleton, .skeleton]
    
    var query: String = ""
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredRepositories.count > 0 {
            return filteredRepositories.count
        }
        return cellType.count
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
    
    func filterForSearchText(searchText: String) {
        filteredRepositories = repos.filter { repo in
            let searchTextMatch = repo.name.lowercased().contains(searchText.lowercased())
            return searchTextMatch
        }
        print(filteredRepositories.count)
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
        catcherController?.didSelectListItem(repos[indexPath.row])
    }
    
}
