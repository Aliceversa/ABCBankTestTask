//
//  ABCBankTestTaskTests.swift
//  ABCBankTestTaskTests
//
//  Created by Andrew Isaenko on 24/02/2026.
//

import XCTest
@testable import ABCBankTestTask

final class MainPagePresenterTests: XCTestCase {
    
    var sut: MainPagePresenterProtocol!
    var mockProvider: PagesProviderProtocol!
    var mockViewController: MockMainPageViewController!
    
    override func setUp() {
        super.setUp()
        mockProvider = MockPagesProvider()
        let presenter = MainPagePresenter(pagesProvider: mockProvider)
        mockViewController = MockMainPageViewController()
        presenter.setViewController(mockViewController)
        sut = presenter
    }
    
    override func tearDown() {
        sut = nil
        mockProvider = nil
        mockViewController = nil
        super.tearDown()
    }
    
    func testViewDidLoad_CallsDisplayPages() async {
        // When
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        // Then
        XCTAssertTrue(mockViewController.displayPagesCalled)
        XCTAssertEqual(mockViewController.displayedPages?.count, 3)
    }
    
    func testViewDidLoad_CallsDisplayCurrentPage() async {
        // When
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        // Then
        XCTAssertTrue(mockViewController.displayCurrentPageCalled)
        XCTAssertEqual(mockViewController.displayedItems?.count, 19)
    }
    
    func testDidSelectPage_UpdatesCurrentPage() async {
        // Given
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        mockViewController.reset()
        
        // When
        sut.didSelectPage(1) // Furniture page
        
        // Then
        XCTAssertTrue(mockViewController.displayCurrentPageCalled)
        XCTAssertEqual(mockViewController.displayedItems?.count, 7)
    }
    
    func testDidSearch_FiltersItems() async {
        // Given
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        mockViewController.reset()
        
        // When
        sut.didSearch("Yamaha")
        
        // Then
        XCTAssertTrue(mockViewController.displayCurrentPageCalled)
        XCTAssertEqual(mockViewController.displayedItems?.count, 2)
    }
    
    func testDidSearch_EmptyText_ShowsAllItems() async {
        // Given
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        sut.didSearch("Yamaha")
        mockViewController.reset()
        
        // When
        sut.didSearch("")
        
        // Then
        XCTAssertTrue(mockViewController.displayCurrentPageCalled)
        XCTAssertEqual(mockViewController.displayedItems?.count, 19)
    }
    
    func testDidTapStatistics_CallsDisplayStatistics() async {
        // Given
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        // When
        sut.didTapStatistics()
        
        // Then
        XCTAssertTrue(mockViewController.displayStatisticsCalled)
        XCTAssertNotNil(mockViewController.displayedStatistics)
    }
}

// MARK: - Mock ViewController

final class MockMainPageViewController: MainPageViewControllerProtocol {
    
    var displayPagesCalled = false
    var displayCurrentPageCalled = false
    var displayStatisticsCalled = false
    
    var displayedPages: [PageModel]?
    var displayedItems: [String]?
    var displayedStatistics: StatisticsModel?
    
    func displayPages(_ pages: [PageModel]) {
        displayPagesCalled = true
        displayedPages = pages
    }
    
    func displayCurrentPage(_ index: Int, items: [String]) {
        displayCurrentPageCalled = true
        displayedItems = items
    }
    
    func displayStatistics(_ statistics: StatisticsModel) {
        displayStatisticsCalled = true
        displayedStatistics = statistics
    }
    
    func reset() {
        displayPagesCalled = false
        displayCurrentPageCalled = false
        displayStatisticsCalled = false
        displayedPages = nil
        displayedItems = nil
        displayedStatistics = nil
    }
}
