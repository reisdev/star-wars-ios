//
//  FilmMock.swift
//  StarWarsDeckTests
//
//  Created by Matheus dos Reis de Jesus on 10/05/22.
//

@testable import StarWarsDeck
import Foundation

final class FilmMock {
    static func mockFilm() -> Film {
        return Film(title: "A New Hope", episodeId: 4, openingCrawl: "", director: "George Lucas", producer: "Gary Kurtz, Rick MacCallum", releaseDate: "1977-03-15", species: [], starships: [], vehicles: [], characters: [], planets: [], url: "", created: "2019-12-05", edited: "2019-12-05")
    }
}
