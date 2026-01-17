//
//  FilmViewProps.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 27/07/23.
//

import Foundation

struct FilmViewProps {
    let episodeId: Int
    let title: String
    let year: String
    let director: String
    let producer: String
    
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let characters: [URL]
    let planets: [URL]

    let openingCrawl: String
}

extension FilmViewProps {
    init(from film: Film) {
        self.episodeId = film.episodeId
        self.title = film.title
        self.year = film.releaseYear
        self.director = film.director
        self.producer = film.producer
        self.characters = film.characters
        self.species = film.species
        self.vehicles = film.vehicles
        self.planets = film.planets
        self.starships = film.starships
        self.openingCrawl = film.openingCrawl
    }
}
