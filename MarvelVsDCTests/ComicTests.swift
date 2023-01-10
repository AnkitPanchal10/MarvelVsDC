//
//  ComicTests.swift
//  MarvelVsDCTests
//
//  Created by Ankit Panchal on 09/01/23.
//

import XCTest
@testable import MarvelVsDC

final class ComicTests: XCTestCase {
    
    var viewModel: ComicProtocol!
    var networkManager: APIManagerMock!
    
    override func setUpWithError() throws {
        networkManager = APIManagerMock(interceptor: APIManagerInterceptor())
        viewModel = ComicViewModel(networkManager: networkManager)
    }
    
    override func tearDownWithError() throws {
        networkManager = nil
        viewModel = nil
    }
    
    func testComicsAPISuccess() {
        // Arrange
        networkManager.expectedJsonData = MockJson.comicListSuccessResponse.getJsonData()
        let expectation = XCTestExpectation(description: "Comic list API success")
        var isSuccess = false
        
        // Act
        viewModel.requestComicsAPI { status in
            isSuccess = status
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(isSuccess)
    }
    
    func testComicsAPIFailure() {
        // Arrange
        let expectation = XCTestExpectation(description: "Comic list API failure")
        var isSuccess = false
        
        // Act
        viewModel.requestComicsAPI { status in
            isSuccess = status
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isSuccess)
    }
    
    func testNumberOfSectionInTable() {
        // Arrange
        networkManager.expectedJsonData = MockJson.comicListSuccessResponse.getJsonData()
        var section = 0
        
        // Act
        viewModel.requestComicsAPI { _ in}
        section = viewModel.numberOfSectionsInTable()
        
        // Assert
        XCTAssertGreaterThan(section, 0)
    }
    
    func testNumberOfRow() {
        // Arrange
        networkManager.expectedJsonData = MockJson.comicListSuccessResponse.getJsonData()
        let section = 1
        var numberOfRow = 0
        
        // Act
        viewModel.requestComicsAPI { _ in}
        numberOfRow = viewModel.numberOfRows(in: section)
        
        // Assert
        XCTAssertGreaterThan(numberOfRow, 0)
    }
    
    func testNumberOfSectionInCollection() {
        // Arrange
        networkManager.expectedJsonData = MockJson.comicListSuccessResponse.getJsonData()
        var section = 0
        
        // Act
        viewModel.requestComicsAPI { _ in}
        section = viewModel.numberOfSectionsInTable()
        
        // Assert
        XCTAssertGreaterThan(section, 0)
    }
    
    func testNumberOfItemInSection() {
        // Arrange
        networkManager.expectedJsonData = MockJson.comicListSuccessResponse.getJsonData()
        let section = 0
        var numberOfItem = 0
        
        // Act
        viewModel.requestComicsAPI { _ in}
        numberOfItem = viewModel.numberOfItemsInSection(section: section)
        
        // Assert
        XCTAssertGreaterThan(numberOfItem, 0)
    }
    
    func testGetComicItem() {
        // Arrange
        networkManager.expectedJsonData = MockJson.comicListSuccessResponse.getJsonData()
        let indexPath = IndexPath(row: 0, section: 0)
        var comicItem: Comic?
        
        // Act
        viewModel.requestComicsAPI { _ in}
        comicItem = viewModel.getComicItem(at: indexPath)
        
        // Assert
        XCTAssertNotNil(comicItem)
    }
    
    func testGetSection() {
        // Arrange
        networkManager.expectedJsonData = MockJson.comicListSuccessResponse.getJsonData()
        var section = 0
        var sectionType: TableViewSection?
        
        // Act
        viewModel.requestComicsAPI { _ in}
        sectionType = viewModel.getSection(section: section)
        
        // Assert
        XCTAssertEqual(sectionType, TableViewSection.marvel)
    }
}
