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
        
        let expectation = expectation(description: "service.get should return the movie")
        
        if film.title == "A New Hope" {
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 10.0)
    }
    
    func test_getAllFilms_shouldSucceed() async throws {
        let response: Response<Film> = try await service.get(.films)
        
        let expectation = expectation(description: "service.get should return the movie")
        
        if !response.results.isEmpty {
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 10.0)
    }
}
