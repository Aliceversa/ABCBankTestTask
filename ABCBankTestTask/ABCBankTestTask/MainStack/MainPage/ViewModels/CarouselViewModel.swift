//
//  CarouselViewModel.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

import Combine

final class CarouselViewModel: CarouselViewModelProtocol {
    
    @Published var pages: [PageModel] = []
    @Published var currentItems: [String] = []
    @Published var isShowingStatistics: Bool = false
    
    private let dataService: PagesProviderProtocol
    private var allItems: [String] = []
    
    init(dataService: PagesProviderProtocol = DataServiceProvider()) {
        self.dataService = dataService
    }
    
    func loadData() {
        Task {
            let pages = await dataService.fetchPages()
            
            await MainActor.run {
                self.pages = pages
                
                if let firstPage = pages.first {
                    self.allItems = firstPage.items
                    self.currentItems = firstPage.items
                }
            }
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
