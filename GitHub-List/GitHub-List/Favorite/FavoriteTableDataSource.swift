//
//  FavoriteTableDataSource.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import UIKit

protocol CatcherFavoriteTableDataSource: AnyObject {
    func didSelectListItem(_ repo: Repository)
    func remove(repo: RepositoryObject)
}

class FavoriteTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var catcherController: CatcherFavoriteTableDataSource?
    
    private var tableView: UITableView
    
    var repos: [RepositoryObject] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func setCells(repos: [RepositoryObject]) {
        self.repos = repos
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath as IndexPath) as! RepositoryCell
        let repo = Repository.create(with: repos[indexPath.row])
        cell.configureWith(repo: repo)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = Repository.create(with: repos[indexPath.row])
        catcherController?.didSelectListItem(repo)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            catcherController?.remove(repo: repos[indexPath.row])
            self.repos.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
}
