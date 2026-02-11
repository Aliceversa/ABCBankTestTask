//
//  DataServiceProvider.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 09/02/2026.
//

import Foundation

class DataServiceProvider: PagesProviderProtocol {
    
    func fetchPages(completion: @escaping ([PageModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let pages = [
                PageModel(
                    imageName: "motorcycle",
                    items: ["Harley-Davidson", "Yamaha", "Kawasaki", "Ducati", "Honda", "Suzuki", "BMW", "Triumph", "KTM", "Aprilia", "Yamaha", "Kawasaki", "Ducati", "Honda", "Suzuki", "Kawasaki", "Ducati", "Honda", "Suzuki"]
                ),
                PageModel(
                    imageName: "furniture",
                    items: ["chair", "sofa", "table", "bed", "desk", "lamp", "wardrobe"]
                ),
                PageModel(
                    imageName: "fruits",
                    items: ["apple", "orange", "banana", "strawberry", "pineapple", "grapes", "raspberries", "watermelon", "apple"]
                ),
            ]
            completion(pages)
        }
    }
    
}
