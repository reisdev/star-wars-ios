//
//  StarWarsServiceMock.swift
//  StarWars
//
//  Created by Matheus Reis on 11/01/2026.
//

import Foundation
@testable import StarWars

final class StarWarsServiceMock: StarWarsServiceProtocol {

    var getFilename: String = ""
    var searchFilename: String = ""

    init(getFilename: String = "", searchFilename: String = "") {
        self.getFilename = getFilename
        self.searchFilename = searchFilename
    }

    func get<T: Decodable>(_ request: StarWarsRequest, id: String?) async throws -> T {
        guard let url = Bundle(for: type(of: self)).url(forResource: getFilename, withExtension: "json") else {
            throw RequestError.badURL
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    func search<T: Decodable>(_ request: StarWarsRequest, search: String) async throws -> T {
        guard let url = Bundle(for: type(of: self)).url(forResource: searchFilename, withExtension: "json") else {
            throw RequestError.badURL
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }


}
