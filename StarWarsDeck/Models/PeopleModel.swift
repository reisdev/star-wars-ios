//
//  PeopleModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct People: Codable {
    var name: String;
    var birthYear: String;
    var eyeColor: String;
    var gender: String;
    var hairColor: String;
    var height: String;
    var mass: String;
    var skinColor: String;
    var homeworld: String;
    var films: [String];
    var species: [String];
    var starships: [String];
    var vehicles: [String];
    var url: String;
    var created: String;
    var edited: String;
    
    enum CodingKeys: String,CodingKey {
        case name = "name"
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case gender = "gender"
        case hairColor = "hair_color"
        case height = "height"
        case mass = "mass"
        case skinColor = "skin_color"
        case homeworld="homeworld"
        case films = "films"
        case species = "species"
        case starships = "starships"
        case vehicles = "vehicles"
        case url = "url"
        case created = "created"
        case edited = "edited"
    }
}
