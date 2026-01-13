//
//  XCTWaiter+Extensions.swift
//  StarWars
//
//  Created by Matheus Reis on 13/01/2026.
//

import XCTest

extension NSPredicate {
    static let exists = NSPredicate(format: "exists == true")
    static let notExists = NSPredicate(format: "exists == false")
}

extension XCTWaiter {
    func wait(
        for predicate: NSPredicate,
        element: XCUIElement,
        timeout: TimeInterval = 5.0,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let result = wait(
            for: [
                XCTNSPredicateExpectation(predicate: predicate, object: element)
            ],
            timeout: timeout
        )

        if result != .completed {
            XCTFail(
                "Failed to complete predicate for element \(element)",
                file: file,
                line: line
            )
        }
    }
}
