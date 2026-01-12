//
//  HomeViewTests.swift
//  StarWarsDeckTests
//
//  Created by Matheus dos Reis de Jesus on 10/05/22.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import StarWars

class HomeViewTests: XCTestCase {
    func testHomeShortcutViewCell() {
        let sut = HomeShortcutViewCell()
        sut.setup(with: HomeShortcut(title: "Films", url: "", iconName: "play.rectangle.fill"))
        assertSnapshot(of: sut, as: .image(size: CGSize(width: UIScreen.main.bounds.width, height: 80)))
    }
    
    func testHomeView() {
        let viewModel = HomeViewModel(service: JSONService(fileName: "home_shortcuts"))
        let sut = HomeViewController(viewModel: viewModel)
        assertSnapshot(of: sut, as: .image)
    }
}
