//
//  DataServiceProtocol.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

protocol PagesProviderProtocol {
    func fetchPages() async -> [PageModel]
}
