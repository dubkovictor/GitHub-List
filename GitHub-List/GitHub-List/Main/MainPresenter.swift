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
    
    var dayRepos: [Repository] = []
    var weekRepos: [Repository] = []
    var monthRepos: [Repository] = []
    
    var currentRange: Range = .month
    
    private var currentPageNumber = 1
    private var pageNumberMonth = 0
    private var pageNumberWeek = 1
    private var pageNumberDay = 1
    
    func setViewDelegate(_ delegate: MainViewDelegate) {
        viewDelegate = delegate
    }
    
    init() {
        apiFetcher.setViewDelegate(self)
    }
    
    func fetcher() {
        apiFetcher.fetchRepositories(pageNum: "\(currentPageNumber)", created: currentDateRange())
    }

    func loadData() {
        switch currentRange {
            case .month:
                pageNumberMonth = pageNumberMonth + 1
                currentPageNumber = pageNumberMonth
            case .week:
                currentPageNumber = pageNumberWeek
                pageNumberWeek = pageNumberWeek + 1
            case .day:
                currentPageNumber = pageNumberDay
                pageNumberDay = pageNumberDay + 1
        }
        
        fetcher()
    }
    
    func loadMonth() {
        if monthRepos.count == 0 {
            loadData()
        }
    }
    
    func loadWeek() {
        if weekRepos.count == 0 {
            loadData()
        }
    }
    
    func loadDay() {
        if dayRepos.count == 0 {
            loadData()
        }
    }
    
    func currentDateRange() -> String {
        switch currentRange {
            case .month:
                return dateRange(range: .month) + ".." + today()
            case .week:
                return dateRange(range: .week) + ".." + today()
            case .day:
                return dateRange(range: .day) + ".." + today()
        }
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
