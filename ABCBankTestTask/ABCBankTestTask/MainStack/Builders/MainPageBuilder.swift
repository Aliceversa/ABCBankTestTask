//
//  MainPageBuilder.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 24/02/2026.
//

import SwiftUI

final class MainPageBuilder {
    
    func build() -> some View {
        let dataService = DataServiceProvider()
        let viewModel = MainPageViewModel(dataService: dataService)
        return MainPageView(viewModel: viewModel)
    }
    
}
