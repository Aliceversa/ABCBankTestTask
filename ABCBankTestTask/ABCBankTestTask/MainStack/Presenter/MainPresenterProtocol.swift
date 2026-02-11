//
//  MainPresenterProtocol.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 09/02/2026.
//


protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectPage(_ index: Int)
    func didSearch(_ text: String)
    func didTapStatistics()
}

