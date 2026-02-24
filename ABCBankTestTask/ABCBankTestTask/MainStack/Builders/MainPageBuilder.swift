//
//  MainPageBuilder.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 24/02/2026.
//

import SwiftUI

final class MainPageBuilder {
    
    func build() -> some View {
        let pagesProvider = MockPagesProvider()
        let viewModel = MainPageViewModel(pagesProvider: pagesProvider)
        return MainPageView(viewModel: viewModel)
    }
    
}

