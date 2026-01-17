//
//  TestScreen.swift
//  StarWars
//
//  Created by Matheus Reis on 13/01/2026.
//

import XCTest

open class TestScreen: AnyObject {

    lazy var app = XCUIApplication()
    lazy var waiter = XCTWaiter()

    required public init() {}

    func waitForExists(
        _ element: XCUIElement,
        timeout: TimeInterval = 5.0,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        waiter.wait(for: .exists, element: element, file: file, line: line)
        return self
    }

    func waitForNotExists(
        _ element: XCUIElement,
        timeout: TimeInterval = 5.0,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        waiter.wait(for: .notExists, element: element, file: file, line: line)
        return self
    }
}
