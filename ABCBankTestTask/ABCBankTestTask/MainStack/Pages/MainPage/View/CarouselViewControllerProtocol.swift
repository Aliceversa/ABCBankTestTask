//
//  MainViewProtocol.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

protocol CarouselViewControllerProtocol: AnyObject {
    func displayPages(_ pages: [PageModel])
    func displayCurrentPage(_ index: Int, items: [String])
    func displayStatistics(_ statistics: StatisticsModel)
}
