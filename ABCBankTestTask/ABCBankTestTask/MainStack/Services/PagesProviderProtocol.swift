//
//  PagesProviderProtocol.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

protocol PagesProviderProtocol {
    func fetchPages() async -> [PageModel]
}
