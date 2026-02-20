//
//  MainViewModelProtocol.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

import Combine

protocol CarouselViewModelProtocol: ObservableObject {
    var pages: [PageModel] { get }
    var currentItems: [String] { get }
    var isShowingStatistics: Bool { get set }
    
    func loadData()
    func selectPage(_ index: Int)
    func search(_ text: String)
    func getStatistics() -> StatisticsModel
}
