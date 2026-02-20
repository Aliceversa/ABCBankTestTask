//
//  PageModel.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

struct PageModel {
    let imageName: String
    let items: [String]
}

extension PageModel {
    static let mockMotorcycles: [String] = [
        "Harley-Davidson", "Yamaha", "Kawasaki",
        "Ducati", "Honda", "Suzuki", "BMW",
        "Triumph", "KTM", "Aprilia", "Yamaha1",
        "Kawasaki1", "Ducati1", "Honda1", "Suzuki1",
        "Kawasaki2", "Ducati2", "Honda2", "Suzuki2"
    ]
    static let mockFurniture: [String] = [
        "chair", "sofa", "table", "bed",
        "desk", "lamp", "wardrobe"
    ]
    static let mockFruits: [String] = [
        "apple", "orange", "banana", "strawberry",
        "pineapple", "grapes", "raspberries", "watermelon",
        "apple1"
    ]
}
