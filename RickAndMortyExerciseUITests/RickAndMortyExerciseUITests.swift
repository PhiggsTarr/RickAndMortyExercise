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
}
