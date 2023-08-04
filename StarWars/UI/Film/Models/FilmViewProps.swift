//
//  FilmViewProps.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 27/07/23.
//

import Foundation

struct FilmViewProps {
    let title: String
    let year: String
    let director: String
    let producer: String
}

extension FilmViewProps {
    init(from film: Film) {
        self.title = film.title
        self.year = film.releaseYear
        self.director = film.director
        self.producer = film.producer
    }
}
