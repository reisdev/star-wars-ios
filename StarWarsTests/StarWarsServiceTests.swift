//
//  StarWarsServiceTests.swift
//  StarWarsTests
//
//  Created by Matheus dos Reis de Jesus on 10/08/23.
//

import XCTest
@testable import StarWars

final class StarWarsServiceTests: XCTestCase {

    lazy var service: StarWarsServiceProtocol = {
        StarWarsService(urlSession: .init(configuration: .ephemeral))
    }()
    
    func test_getFilmById_shouldSucceed() async throws {
        let film: Film = try await service.get(.films,id: "1")
        
        XCTAssertEqual(film.title, "A New Hope")
    }
    
    func test_getAllFilms_shouldSucceed() async throws {
        let response: [Film] = try await service.get(.films)

        XCTAssertFalse(response.isEmpty)
    }
}
