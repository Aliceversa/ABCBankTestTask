//
//  MainPresenter.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

final class CarouselPresenter {
    
    private weak var viewController: CarouselViewControllerProtocol?
    private let dataService: PagesProviderProtocol
    
    private var pages: [PageModel] = []
    private var currentPageIndex: Int = 0
    private var allItems: [String] = []
    
    init(dataService: PagesProviderProtocol = DataServiceProvider()) {
        self.dataService = dataService
    }
    
    public func setViewController(_ viewController: CarouselViewControllerProtocol) {
        self.viewController = viewController
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

// MARK: - CarouselPresenterProtocol realisation

extension CarouselPresenter: CarouselPresenterProtocol {
    
    func viewDidLoad() {
        Task {
            let pages = await dataService.fetchPages()
            self.pages = pages
            
            await MainActor.run {            
                self.viewController?.displayPages(pages)
            }
            
            if let firstPage = pages.first {
                self.allItems = firstPage.items
                await MainActor.run {
                    self.viewController?.displayCurrentPage(0, items: firstPage.items)
                }
            }
        }
    }

    func didSelectPage(_ index: Int) {
        currentPageIndex = index
        allItems = pages[index].items
        self.viewController?.displayCurrentPage(index, items: allItems)
    }
    
    func didSearch(_ text: String) {
        if text.isEmpty {
            viewController?.displayCurrentPage(currentPageIndex, items: allItems)
        } else {
            let filtered = allItems.filter { $0.lowercased().contains(text.lowercased()) }
            viewController?.displayCurrentPage(currentPageIndex, items: filtered)
        }
    }
    
    func didTapStatistics() {
        let statistics = calculateStatistics()
        viewController?.displayStatistics(statistics)
    }
    
}
