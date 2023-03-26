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
    func didSelectListItem(_ index: IndexPath)
}

class MainTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var catcherController: CatcherMainTableDataSource?
    
    private var tableView: UITableView
    
    var repos: [Repository] = []
    
    var cellType: [RepoCellType] = [.skeleton, .skeleton, .skeleton, .skeleton]
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        catcherController?.didSelectListItem(indexPath)
    }
    
}
