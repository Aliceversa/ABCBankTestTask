//
//  MainPresenter.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 09/02/2026.
//

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    private let dataService: PagesProviderProtocol
    private var pages: [PageModel] = []
    private var currentPageIndex: Int = 0
    
    init(dataService: PagesProviderProtocol = DataServiceProvider()) {
        self.dataService = dataService
    }
    
    func viewDidLoad() {
        dataService.fetchPages { [weak self] pages in
            guard let self else { return }
            
            self.pages = pages
            self.view?.displayPages(pages)
            
            if let firstPage = pages.first {
                self.view?.displayCurrentPage(0, items: firstPage.items)
            }
        }
    }
    
    func didSelectPage(_ index: Int) {
        currentPageIndex = index
        let items = pages[index].items
        self.view?.displayCurrentPage(index, items: items)
    }
    
    func didSearch(_ text: String) {
        
    }
    
    func didTapStatistics() {
        
    }
    
}
