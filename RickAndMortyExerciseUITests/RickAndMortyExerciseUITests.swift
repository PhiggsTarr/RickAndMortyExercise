//
//  RickAndMortyExerciseUITests.swift
//  RickAndMortyExerciseUITests
//
//  Created by Kevin Tarr on 2/20/25.
//

import XCTest

final class RickAndMortyExerciseUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAppLaunchesSuccessfully() throws {
        let title = app.staticTexts["Rick and Morty Search"]
        XCTAssertTrue(title.exists, "The app should display the main title on launch.")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testVoiceOverAccessibility() throws {
        let searchBar = app.textFields["searchField"]
        XCTAssertTrue(searchBar.exists, "Search bar should exist")
        XCTAssertEqual(searchBar.label, "Search Characters", "Search bar accessibility label should be correct")
        
        let clearFiltersButton = app.buttons["clearFiltersButton"]
        XCTAssertTrue(clearFiltersButton.exists, "Clear Filters button should exist")
        XCTAssertEqual(clearFiltersButton.label, "Clear Filters", "Clear Filters button accessibility label should be correct")
        
        XCUIDevice.shared.orientation = .portrait
        
        searchBar.tap()
        searchBar.typeText("Rick Sanchez")
        app.keyboards.buttons["Return"].tap()
        
        let characterCell = app.staticTexts["CharacterName_Rick Sanchez_Cell_Number_1"]
        app.swipeUp()
        XCTAssertTrue(characterCell.waitForExistence(timeout: 10), "Rick Sanchez should appear in the search results")
        XCTAssertTrue(characterCell.exists, "Character cell for Rick Sanchez should exist")
        XCTAssertEqual(characterCell.label, "Rick Sanchez", "Character cell accessibility label should be correct")

    }


      func testDynamicTextSupport() throws {
          app.launchArguments.append("-UIPreferredContentSizeCategoryName")
          app.launchArguments.append("UICTContentSizeCategoryXXXL")
          app.launch()

          let title = app.staticTexts["Rick and Morty Search"]
          XCTAssertTrue(title.exists, "App title should be visible with large text settings")

          let searchBar = app.textFields["searchField"]
          XCTAssertTrue(searchBar.exists, "Search bar should be visible with large text settings")

          let clearFiltersButton = app.buttons["clearFiltersButton"]
          XCTAssertTrue(clearFiltersButton.exists, "Clear Filters button should be visible with large text settings")
      }
}
