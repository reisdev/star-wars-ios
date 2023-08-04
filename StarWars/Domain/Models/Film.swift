//
//  Film.swift
//  StarWars
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct Film: Model {    
    // - MARK: Attributes
    var title: String
    var episodeId: Int;
    var openingCrawl: String;
    var director: String;
    var producer: String;
    var releaseDate: String;
    var species: [String];
    var starships: [String];
    var vehicles: [String];
    var characters: [String];
    var planets: [String];
    var url: String;
    var created: String;
    var edited: String;
    var releaseYear: String {
        get {
            return releaseDate.count > 0 ? String(releaseDate.split(separator: "-")[0])
                : ""
        }
    }
    
    enum CodingKeys: String,CodingKey {
        case title = "title"
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case director = "director"
        case producer = "producer"
        case releaseDate = "release_date"
        case species = "species"
        case starships = "starships"
        case vehicles = "vehicles"
        case characters = "characters"
        case planets = "planets"
        case url = "url"
        case created = "created"
        case edited = "edited"
    }
    
    func getCellInfo() -> String {
        return title
    }
}
