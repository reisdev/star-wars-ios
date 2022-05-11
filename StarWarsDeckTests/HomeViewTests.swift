//
//  HomeViewTests.swift
//  StarWarsDeckTests
//
//  Created by Matheus dos Reis de Jesus on 10/05/22.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import StarWarsDeck

class HomeViewTests: XCTestCase {
    func testHomeShortcutViewCell() {
        let sut = HomeShortcutViewCell()
        
        sut.setup(with: HomeShortcut(title: "Films", url: "", icon: .init(systemName: "play.rectangle.fill")))
        
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: UIScreen.main.bounds.width, height: 80)))
    }
    
    func testHomeView() {
        let sut = HomeViewController()
        assertSnapshot(matching: sut, as: .image)
    }    
}
