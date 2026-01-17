//
//  PeopleModel.swift
//  StarWars
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct People: Model {
    let name: String
    let birthYear: String
    let eyeColor: String
    let gender: String
    let hairColor: String
    let height: String
    let mass: String
    let skinColor: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let url: URL
    let created: String
    let edited: String

    func getCellInfo() -> String {
        name
    }
}
