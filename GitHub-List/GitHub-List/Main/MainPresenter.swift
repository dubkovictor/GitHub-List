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
    
    private var dateQuery: String = ""
    
    private var currentRange: Range = .month
    
    private var currentPageNumber = 1
    private var pageNumberMonth = 1
    private var pageNumberWeek = 1
    private var pageNumberDay = 1
    
    func setViewDelegate(_ delegate: MainViewDelegate) {
        viewDelegate = delegate
    }
    
    init() {
        apiFetcher.setViewDelegate(self)
    }
    
    func fetcher() {
        apiFetcher.fetchRepositories(pageNum: "\(currentPageNumber)", created: dateQuery)
    }
    
    func loadData() {
        
        switch currentRange {
            case .month:
                pageNumberMonth = pageNumberMonth + 1
                currentPageNumber = pageNumberMonth
            case .week:
                pageNumberWeek = pageNumberWeek + 1
                currentPageNumber = pageNumberWeek
            case .day:
                pageNumberDay = pageNumberDay + 1
                currentPageNumber = pageNumberDay
        }
        
        fetcher()
    }
    
    func lastMonthSelected() {
        currentRange = .month
        dateQuery = dateRange(range: .month) + ".." + today()
        fetcher()
    }
    
    func lastWeekSelected() {
        currentRange = .week
        dateQuery = dateRange(range: .week) + ".." + today()
        fetcher()
    }
    
    func lastDaySelected() {
        currentRange = .day
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
        viewDelegate?.showError(message: message)
    }
    
    func showProgress(_ show: Bool) {
        viewDelegate?.showProgress(show: show)
    }
    
    func showResult(repositories: [Repository]) {
        viewDelegate?.showRepos(repos: repositories)
    }
    
    
}
