//
//  CarouselViewModel.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 12/02/2026.
//

import Combine

final class CarouselViewModel: CarouselViewModeling {
    
    @Published var pages: [PageModel] = []
    @Published var currentItems: [String] = []
    @Published var isShowingStatistics: Bool = false
    
    private let dataService: PagesProviderProtocol
    private var allItems: [String] = []
    
    init(dataService: PagesProviderProtocol = DataServiceProvider()) {
        self.dataService = dataService
    }
    
    func loadData() {
        dataService.fetchPages { [weak self] pages in
            guard let self = self else { return }
            self.pages = pages
            
            if let firstPage = pages.first {
                self.allItems = firstPage.items
                self.currentItems = firstPage.items
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
        let pageStats = pages.enumerated().map { (index, page) in
            (pageNumber: index + 1, itemCount: page.items.count)
        }
        
        // Calculate all characters (without spaces and symbols)
        var characterCounts: [Character: Int] = [:]
        for page in pages {
            for item in page.items {
                for char in item.lowercased() {
                    if char.isLetter {
                        characterCounts[char, default: 0] += 1
                    }
                }
            }
        }
        
        // Get top 3 characters
        let topCharacters = characterCounts
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { (character: $0.key, count: $0.value) }
        
        return StatisticsModel(pageStats: pageStats, topCharacters: topCharacters)
    }
    
}

