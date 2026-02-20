//
//  ABCBankTestApp.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//


import SwiftUI

@main
struct ABCBankTestTaskApp: App {
    
    var body: some Scene {
        WindowGroup {
            CarouselView(viewModel: CarouselViewModel())
        }
    }
    
}
