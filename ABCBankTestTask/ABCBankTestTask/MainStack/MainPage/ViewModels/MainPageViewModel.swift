//
//  MainPageViewModel.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

import Combine

final class MainPageViewModel: MainPageViewModelProtocol {
    
    @Published var pages: [PageModel] = []
    @Published var currentItems: [String] = []
    
    private let pagesProvider: PagesProviderProtocol
    private var allItems: [String] = []
    private var cachedStatistics: StatisticsModel?
    
    private var loadDataTask: Task<Void, Never>?
    
    init(pagesProvider: PagesProviderProtocol) {
        self.pagesProvider = pagesProvider
    }
    
    deinit {
        loadDataTask?.cancel()
    }
    
    private func calculateAndCacheStatistics() async {
        let statistics = await Task.detached { [weak self] in
            guard let self, !Task.isCancelled else { return StatisticsModel(pagesStats: [], topCharactersStats: []) }
            return self.calculateStatistics()
        }.value
        
        guard !Task.isCancelled else { return }
        cachedStatistics = statistics
    }
    
    private func calculateStatistics() -> StatisticsModel {
        // Get pages statistics (number and items count)
        let pageStats: [PageStat] = pages.enumerated().map { (index, page) in
            PageStat(pageNumber: index + 1, itemCount: page.items.count)
        }
        
        // Calculate all characters (without spaces and symbols)
        let characterCounts: [Character: Int] = pages
           .flatMap { $0.items }
           .joined()
           .lowercased()
           .filter { $0.isLetter }
           .reduce(into: [:]) { counts, char in
               counts[char, default: 0] += 1
           }
        
        // Get top 3 characters
        let topCharactersStats = characterCounts
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { TopCharacterStat(character: $0.key, count: $0.value) }
        
        return StatisticsModel(pagesStats: pageStats, topCharactersStats: topCharactersStats)
    }
    
}

extension MainPageViewModel {
    
    func loadData() {
        
        // Cancel previous task if exists
        loadDataTask?.cancel()
        
        loadDataTask = Task { [weak self] in
            guard let self else { return }
            let pages = await pagesProvider.fetchPages()
            
            guard !Task.isCancelled else { return }
            
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.pages = pages
                
                if let firstPage = pages.first {
                    self.allItems = firstPage.items
                    self.currentItems = firstPage.items
                }
            }
            
            guard !Task.isCancelled else { return }
            await calculateAndCacheStatistics()
        }
    }
    
    func selectPage(_ index: Int) {
        guard index < pages.count else { return }
        allItems = pages[index].items
        currentItems = allItems
    }
    
    func search(_ text: String) {
        if text.isEmpty {
            currentItems = allItems
        } else {
            currentItems = allItems.filter { $0.lowercased().contains(text.lowercased()) }
        }
    }
    
    func getStatistics() -> StatisticsModel {
        return cachedStatistics ?? StatisticsModel(pagesStats: [], topCharactersStats: [])
    }
    
}
