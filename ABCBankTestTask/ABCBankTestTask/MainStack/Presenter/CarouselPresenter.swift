//
//  MainPresenter.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 09/02/2026.
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
    
    public func setViewController(_ vc: CarouselViewControllerProtocol) {
        self.viewController = vc
    }
    
    private func calculateStatistics() -> StatisticsModel {
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

// MARK: - CarouselPresenterProtocol realisation

extension CarouselPresenter: CarouselPresenterProtocol {
    
    func viewDidLoad() {
        dataService.fetchPages { [weak self] pages in
            guard let self else { return }
            
            self.pages = pages
            self.viewController?.displayPages(pages)
            
            if let firstPage = pages.first {
                self.allItems = firstPage.items
                self.viewController?.displayCurrentPage(0, items: firstPage.items)
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
