//
//  MainTableDataSource.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

enum Mode {
    case day
    case week
    case month
}

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
    
    var currentRepo: [Repository] = []
    var dayRepos: [Repository] = []
    var weekRepos: [Repository] = []
    var monthRepos: [Repository] = []
    
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
    
    func updateData(repos: [Repository], mode: Mode) {
        var cells: [RepoCellType] = []
        self.currentRepo.removeAll()
        print(mode)
        cellType.removeAll()
        switch mode {
            case .month:
                monthRepos.append(contentsOf: repos)
                self.currentRepo = monthRepos
            case .week:
                weekRepos.append(contentsOf: repos)
                self.currentRepo = weekRepos
            case .day:
                dayRepos.append(contentsOf: repos)
                self.currentRepo = dayRepos
        }
        
        for item in self.currentRepo {
            cells.append(.repoCell(item))
        }
        
        cellType.append(contentsOf: cells)
        
        print("load data finished")
        
        tableView.reloadData()
        
        isLoading = false
    }
    
    func setCells(repos: [Repository]) {
        cellType.removeAll()
        self.currentRepo = repos
        
        if repos.count > 0 {
            for item in repos {
                cellType.append(.repoCell(item))
            }
        }
        tableView.reloadData()
    }
    
    func resetFilter() {
        filteredRepositories.removeAll()
        setCells(repos: currentRepo)
    }
    
    func filterForSearchText(searchText: String) {
        filteredRepositories = currentRepo.filter { repo in
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
        guard currentRepo.count != 0 else { return }
        catcherController?.didSelectListItem(currentRepo[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellType.count - 5 {
            if !isLoading {
                isLoading = true
                print("load additionaly data")
                catcherController?.loadData()
            }
        }
    }
}
