//
//  MainViewModelProtocol.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 12/02/2026.
//

import Combine

protocol CarouselViewModeling: ObservableObject {
    var pages: [PageModel] { get }
    var currentItems: [String] { get }
    var isShowingStatistics: Bool { get set }
    
    func loadData()
    func selectPage(_ index: Int)
    func search(_ text: String)
    func getStatistics() -> StatisticsModel
}

