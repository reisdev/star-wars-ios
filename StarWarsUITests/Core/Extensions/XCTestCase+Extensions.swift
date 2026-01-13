//
//  XCTestCase+Extensions.swift
//  StarWars
//
//  Created by Matheus Reis on 13/01/2026.
//

import XCTest

open class UITestCase<Screen: TestScreen>: XCTestCase {

    var screen: Screen!

    open override func setUp() {
        super.setUp()
        screen = Screen()
        screen.app.launch()
    }
}
