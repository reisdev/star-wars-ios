//
//  FilmViewUITests.swift
//  StarWarsTests
//
//  Created by Matheus dos Reis de Jesus on 10/05/22.
//

import SnapshotTesting
import XCTest
import RxSwift
@testable import StarWars

class FilmViewTests: XCTestCase {
    func testFilmView() {
        let viewModel = FilmViewModel(film: .mock())
        let sut = FilmViewController(viewModel: viewModel)
        assertSnapshot(of: sut, as: .image(on: .iPhone13))
    }
}
