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
    let disposeBag = DisposeBag()
    func testFilmView() {
        let expectation = expectation(description: "props updated")
        let service = StarWarsServiceMock(getFilename: "film_1")
        let viewModel = FilmViewModel(service: service, id: "1")
        viewModel.props.first().subscribe { _ in
            expectation.fulfill()
        }.disposed(by: disposeBag)
        let viewController = FilmViewController(viewModel: viewModel)
        wait(for: [expectation], timeout: 5.0)
        assertSnapshot(of: viewController, as: .image)
    }
}
