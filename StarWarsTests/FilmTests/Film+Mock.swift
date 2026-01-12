//
//  Film+Mock.swift
//  StarWarsDeckTests
//
//  Created by Matheus dos Reis de Jesus on 10/05/22.
//

@testable import StarWars
import Foundation

extension Film {
    static func mock() -> Film {
        Film(
            title: "A New Hope",
            episodeId: 4,
            openingCrawl: "",
            director: "George Lucas",
            producer: "Gary Kurtz, Rick MacCallum",
            releaseDate: "1977-03-15",
            species: [],
            starships: [],
            vehicles: [],
            characters: [],
            planets: [],
            url: URL(string: "")!,
            created: "2019-12-05",
            edited: "2019-12-05"
        )
    }
}
