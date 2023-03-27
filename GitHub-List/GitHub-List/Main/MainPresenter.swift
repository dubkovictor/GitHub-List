//
//  MainPresenter.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

enum Range {
    case day
    case week
    case month
}

class MainPresenter {
    
    private weak var viewDelegate: MainViewDelegate?
    
    private var apiFetcher = APIFetcher()
    
    var dateQuery: String = ""
    
    func setViewDelegate(_ delegate: MainViewDelegate) {
        viewDelegate = delegate
    }
    
    init() {
        apiFetcher.setViewDelegate(self)
        lastMonthSelected()
    }
    
    func fetcher() {
        apiFetcher.fetchRepositories(query: dateQuery)
    }
    
    func lastMonthSelected() {
        dateQuery = dateRange(range: .month) + ".." + today()
        fetcher()
    }
    
    func lastWeekSelected() {
        dateQuery = dateRange(range: .week) + ".." + today()
        fetcher()
    }
    
    func lastDaySelected() {
        dateQuery = dateRange(range: .day) + ".." + today()
        fetcher()
    }
    
    private func dateRange(range: Range) -> String {
        switch range {
            case .day:
                return lastDayDate()
            case .week:
                return lastWeekDate()
            case .month:
                return lastMonthDate()
        }
    }
    
    private func lastDayDate() -> String {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private func lastWeekDate() -> String {
        let date = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private func lastMonthDate() -> String {
        let date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private func today() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    
}

extension MainPresenter: APIFetcherDelegate {
    func showError(message: String) {
        
    }
    
    func showProgress(_ show: Bool) {
        viewDelegate?.showProgress(show: show)
    }
    
    func showResult(repositories: [Repository]) {
        viewDelegate?.showRepos(repos: repositories)
    }
    
    
}
