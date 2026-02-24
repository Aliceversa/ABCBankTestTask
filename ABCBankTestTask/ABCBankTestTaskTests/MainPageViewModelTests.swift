//
//  MainPageViewModelTests.swift
//  MainPageViewModelTests
//
//  Created by Andrew Isaenko on 24/02/2026.
//

import XCTest
@testable import ABCBankTestTask

final class MainPageViewModelTests: XCTestCase {
    
    var sut: (any MainPageViewModelProtocol)!
    var mockProvider: PagesProviderProtocol!
    
    override func setUp() {
        super.setUp()
        mockProvider = MockPagesProvider()
        sut = MainPageViewModel(pagesProvider: mockProvider)
    }
    
    override func tearDown() {
        sut = nil
        mockProvider = nil
        super.tearDown()
    }
    
    func testLoadData_UpdatesPages() async {
        // When
        sut.loadData()
        try? await Task.sleep(nanoseconds: 1_500_000_000) // Wait for async
        
        // Then
        XCTAssertEqual(sut.pages.count, 3)
        XCTAssertEqual(sut.currentItems.count, 19) // First page items
    }
    
    func testSelectPage_UpdatesCurrentItems() {
        // Given
        let pages = MockPagesProvider().fetchPagesSync()
        (sut as? MainPageViewModel)?.pages = pages
        
        // When
        sut.selectPage(1) // Furniture page
        
        // Then
        XCTAssertEqual(sut.currentItems.count, 7)
        XCTAssertTrue(sut.currentItems.contains("chair"))
    }
    
    func testSearch_FiltersItems() {
        // Given
        let pages = MockPagesProvider().fetchPagesSync()
        (sut as? MainPageViewModel)?.pages = pages
        sut.selectPage(0) // Motorcycle page
        
        // When
        sut.search("Yamaha")
        
        // Then
        XCTAssertEqual(sut.currentItems.count, 2) // Yamaha + Yamaha1
        XCTAssertTrue(sut.currentItems.allSatisfy { $0.contains("Yamaha") })
    }
    
    func testSearch_EmptyText_ShowsAllItems() {
        // Given
        let pages = MockPagesProvider().fetchPagesSync()
        (sut as? MainPageViewModel)?.pages = pages
        sut.selectPage(0)
        sut.search("Yamaha")
        
        // When
        sut.search("")
        
        // Then
        XCTAssertEqual(sut.currentItems.count, 19) // All motorcycle items
    }
    
    func testGetStatistics_ReturnsCorrectData() async {
        // Given
        sut.loadData()
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        // When
        let stats = sut.getStatistics()
        
        // Then
        XCTAssertEqual(stats.pagesStats.count, 3)
        XCTAssertEqual(stats.topCharactersStats.count, 3)
    }
}

// Helper for sync access
extension MockPagesProvider {
    func fetchPagesSync() -> [PageModel] {
        [
            PageModel(imageName: "motorcycle", items: ["Harley-Davidson", "Yamaha", "Kawasaki", "Ducati", "Honda", "Suzuki", "BMW", "Triumph", "KTM", "Aprilia", "Yamaha1", "Kawasaki1", "Ducati1", "Honda1", "Suzuki1", "Kawasaki2", "Ducati2", "Honda2", "Suzuki2"]),
            PageModel(imageName: "furniture", items: ["chair", "sofa", "table", "bed", "desk", "lamp", "wardrobe"]),
            PageModel(imageName: "fruits", items: ["apple", "orange", "banana", "strawberry", "pineapple", "grapes", "raspberries", "watermelon", "apple1"])
        ]
    }
}
