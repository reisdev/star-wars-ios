//
//  HomeScreen.swift
//  StarWars
//
//  Created by Matheus Reis on 13/01/2026.
//

import XCTest
@testable import StarWars

final class HomeScreen: TestScreen {

    var view: XCUIElement {
        app.otherElements[A11yIdentifiers.Home.view]
    }

    var logo: XCUIElement {
        app.images[A11yIdentifiers.Home.logo]
    }

    var collectionView: XCUIElement {
        app.collectionViews[A11yIdentifiers.Home.collectionView]
    }

    var collectionsItems: [XCUIElement] {
        collectionView.cells.allElementsBoundByIndex
    }

    @discardableResult
    func validateViewExists() -> Self {
        waitForExists(view)
    }

    @discardableResult
    func validateLogoExists() -> Self {
        waitForExists(logo)
    }

    @discardableResult
    func validateCollectionViewExists() -> Self {
        waitForExists(collectionView)
    }

    @discardableResult
    func validateCollectionViewHasItems(count: Int) -> Self {
        XCTAssertEqual(collectionsItems.count, count)
        return self
    }
}
