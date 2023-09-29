//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import XCTest

final class NewsAppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {

        continueAfterFailure = false
        app.launch()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_NewsViewController_ligthDarkToggleButton_shouldToggle () {

        let newsNavigationBar = app.navigationBars["News"]
        let toggleBtn = newsNavigationBar.buttons["LigthDarkToggleButton"]
        toggleBtn.tap()

        XCTAssertTrue(toggleBtn.exists)
    }

    func test_NewsFilterViewController_rightBarButtonItem_shouldClearResults () {

        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let firstArticle = collectionViewsQuery.cells["Arcticle0"].children(matching: .other).element.children(matching: .other).element
        app.navigationBars["News"].buttons["edit"].tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 13).children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 8).children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
        app.navigationBars["Filter articles by source!"].buttons["Clear"].tap()

        XCTAssertTrue(firstArticle.exists)

    }
}
