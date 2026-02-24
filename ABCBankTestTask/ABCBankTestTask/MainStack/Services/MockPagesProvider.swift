//
//  MockPagesProvider.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

import Foundation
import UIKit

class MockPagesProvider: PagesProviderProtocol {
    
    func fetchPages() async -> [PageModel] {
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let pages: [PageModel] = [
            PageModel(
                imageName: ImageAssetsNames.motorcycleImageName,
                items: [
                    "Harley-Davidson", "Yamaha", "Kawasaki",
                    "Ducati", "Honda", "Suzuki", "BMW",
                    "Triumph", "KTM", "Aprilia", "Yamaha1",
                    "Kawasaki1", "Ducati1", "Honda1", "Suzuki1",
                    "Kawasaki2", "Ducati2", "Honda2", "Suzuki2"
                ]
            ),
            PageModel(
                imageName: ImageAssetsNames.furnitureImageName,
                items: [
                    "chair", "sofa", "table", "bed",
                    "desk", "lamp", "wardrobe"
                ]
            ),
            PageModel(
                imageName: ImageAssetsNames.fruitsImageName,
                items: [
                    "apple", "orange", "banana", "strawberry",
                    "pineapple", "grapes", "raspberries", "watermelon",
                    "apple1"
                ]
            ),
        ]
        return pages
    }
    
}
