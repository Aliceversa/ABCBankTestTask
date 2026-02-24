//
//  MainPresenterProtocol.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

protocol MainPagePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectPage(_ index: Int)
    func didSearch(_ text: String)
    func didTapStatistics()
}
