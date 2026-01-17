//
//  HomeUITests.swift
//  StarWarsUITests
//
//  Created by Matheus Reis on 13/01/2026.
//

import XCTest

final class HomeUITests: UITestCase<HomeScreen> {

    func test_hasAllComponents() {
        screen.validateViewExists()
            .validateLogoExists()
            .validateCollectionViewExists()
            .validateCollectionViewHasItems(count: 6)
    }
}
