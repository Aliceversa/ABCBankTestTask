//
//  Builder.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

import UIKit

final class MainBuilder {
    
    func build() -> UIViewController {
        let presenter = CarouselPresenter()
        let mainViewController = CarouselViewController(presenter: presenter)
        presenter.setViewController(mainViewController)
        
        return mainViewController
    }
    
}
