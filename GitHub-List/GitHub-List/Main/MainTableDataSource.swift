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
    
    var mode: Mode = .month
    
    var currentRepo: [Repository] = []
    var dayRepos: [Repository] = []
    var weekRepos: [Repository] = []
    var monthRepos: [Repository] = []
    
    var filteredRepositories = [Repository]()
    
    var cellType: [RepoCellType] = [.skeleton, .skeleton, .skeleton]
    var cellTypeMonth: [RepoCellType] = []
    var cellTypeWeek: [RepoCellType] = []
    var cellTypeDay: [RepoCellType] = []
    
    var query = ""
    var searchText = ""
    
    var isLoading = true
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredRepositories.count > 0 {
            return filteredRepositories.count
        }
        return cellType.count
    }
    
    func setMonthCells(repos: [Repository]) {
        cellType.removeAll()
        for item in repos {
            cellTypeMonth.append(.repoCell(item))
        }
        monthRepos.append(contentsOf: repos)
        showMonth()
        isLoading = false
    }
    
    func setWeekCells(repos: [Repository]) {
        cellType.removeAll()
        for item in repos {
            cellTypeWeek.append(.repoCell(item))
        }
        weekRepos.append(contentsOf: repos)
        isLoading = false
        showWeek()
    }
    
    func setDayCells(repos: [Repository]) {
        cellType.removeAll()
        for item in repos {
            cellTypeDay.append(.repoCell(item))
        }
        dayRepos.append(contentsOf: repos)
        isLoading = false
        showDay()
    }
    
    func showMonth() {
        currentRepo = monthRepos
        cellType = cellTypeMonth
        tableView.reloadData()
    }
    
    func showWeek() {
        currentRepo = weekRepos
        cellType = cellTypeWeek
        tableView.reloadData()
    }
    
    func showDay() {
        currentRepo = dayRepos
        cellType = cellTypeDay
        tableView.reloadData()
    }

    func resetFilter() {
        filteredRepositories.removeAll()
        switch mode {
            case .month:
                setMonthCells(repos: currentRepo)
            case .week:
                setWeekCells(repos: currentRepo)
            case .day:
                setDayCells(repos: currentRepo)
        }
        searchText = ""
    }
    
    func filterForSearchText(searchText: String) {
        self.searchText = searchText
        
        filteredRepositories = currentRepo.filter { repo in
            let searchTextMatch = repo.name.lowercased().contains(searchText.lowercased())
            return searchTextMatch
        }
        
        if filteredRepositories.count > 0 {
            cellType.removeAll()
            for item in filteredRepositories {
                cellType.append(.repoCell(item))
            }
        } else {
            cellType.removeAll()
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
        if indexPath.row == currentRepo.count - 2 {
            if !isLoading {
                isLoading = true
                catcherController?.loadData()
            }
        }
    }
}
