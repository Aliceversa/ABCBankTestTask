//
//  PagesProviderProtocol.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 12/02/2026.
//

protocol PagesProviderProtocol {
    func fetchPages(completion: @escaping ([PageModel]) -> Void)
}
