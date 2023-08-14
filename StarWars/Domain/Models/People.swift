//
//  PeopleModel.swift
//  StarWars
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct People: Model {
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
    
    func getCellInfo() -> String {
        return name
    }
}
