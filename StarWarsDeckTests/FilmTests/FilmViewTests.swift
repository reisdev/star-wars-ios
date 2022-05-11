//
//  FilmViewUITests.swift
//  StarWarsDeckUITests
//
//  Created by Matheus dos Reis de Jesus on 10/05/22.
//

import SnapshotTesting
import XCTest
@testable import StarWarsDeck

class FilmViewTests: XCTestCase {
    func testFilmView() {
        let viewModel = FilmViewModel(FilmMock.mockFilm())
        
        let viewController = FilmViewController(viewModel: viewModel)
        assertSnapshot(matching: viewController, as: .image)
    }
}
