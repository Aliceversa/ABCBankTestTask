//
//  DataServiceProvider.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

import Foundation
import UIKit

class DataServiceProvider: PagesProviderProtocol {
    
    func fetchPages() async -> [PageModel] {
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let pages: [PageModel] = [
            PageModel(
                imageName: ImageAssetsNames.motorcycleImageName,
                items: PageModel.mockMotorcycles
            ),
            PageModel(
                imageName: ImageAssetsNames.furnitureImageName,
                items: PageModel.mockFurniture
            ),
            PageModel(
                imageName: ImageAssetsNames.fruitsImageName,
                items: PageModel.mockFruits
            ),
        ]
        return pages
    }
    
}
