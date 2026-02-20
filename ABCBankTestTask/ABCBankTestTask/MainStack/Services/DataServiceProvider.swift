//
//  DataServiceProvider.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 12/02/2026.
//

import Foundation

class DataServiceProvider: PagesProviderProtocol {
    
    func fetchPages(completion: @escaping ([PageModel]) -> Void) {
        let pages = [
            PageModel(
                imageName: "motorcycle",
                items: ["Harley-Davidson", "Yamaha", "Kawasaki", "Ducati", "Honda", "Suzuki", "BMW", "Triumph", "KTM", "Aprilia", "Yamaha2", "Kawasaki2", "Ducati2", "Honda2", "Suzuki2", "Kawasaki3", "Ducati3", "Honda3", "Suzuki3"]
            ),
            PageModel(
                imageName: "furniture",
                items: ["chair", "sofa", "table", "bed", "desk", "lamp", "wardrobe"]
            ),
            PageModel(
                imageName: "fruits",
                items: ["apple", "orange", "banana", "strawberry", "pineapple", "grapes", "raspberries", "watermelon", "apple2"]
            ),
        ]
        completion(pages)
    }
    
}
