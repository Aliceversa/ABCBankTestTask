//
//  Untitled.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 24/02/2026.
//

import XCTest
@testable import ABCBankTestTask

final class MockPagesProviderTests: XCTestCase {
    
    var sut: PagesProviderProtocol!
    
    override func setUp() {
        super.setUp()
        sut = MockPagesProvider()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchPages_ReturnsThreePages() async {
        // When
        let pages = await sut.fetchPages()
        
        // Then
        XCTAssertEqual(pages.count, 3)
    }
    
    func testFetchPages_FirstPageIsMotorcycles() async {
        // When
        let pages = await sut.fetchPages()
        
        // Then
        XCTAssertEqual(pages[0].imageName, ImageAssetsNames.motorcycleImageName)
        XCTAssertEqual(pages[0].items.count, 19)
        XCTAssertTrue(pages[0].items.contains("Harley-Davidson"))
    }
    
    func testFetchPages_SecondPageIsFurniture() async {
        // When
        let pages = await sut.fetchPages()
        
        // Then
        XCTAssertEqual(pages[1].imageName, ImageAssetsNames.furnitureImageName)
        XCTAssertEqual(pages[1].items.count, 7)
        XCTAssertTrue(pages[1].items.contains("chair"))
    }
    
    func testFetchPages_ThirdPageIsFruits() async {
        // When
        let pages = await sut.fetchPages()
        
        // Then
        XCTAssertEqual(pages[2].imageName, ImageAssetsNames.fruitsImageName)
        XCTAssertEqual(pages[2].items.count, 9)
        XCTAssertTrue(pages[2].items.contains("apple"))
    }
    
    func testFetchPages_HasDelay() async {
        // Given
        let startTime = Date()
        
        // When
        _ = await sut.fetchPages()
        
        // Then
        let elapsed = Date().timeIntervalSince(startTime)
        XCTAssertGreaterThan(elapsed, 0.9) // Should take ~1 second
    }
}
