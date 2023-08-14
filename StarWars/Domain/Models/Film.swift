//
//  Film.swift
//  StarWars
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct Film: Model {    
    // - MARK: Attributes
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let characters: [URL]
    let planets: [URL]
    let url: String;
    let created: String;
    let edited: String;
    var releaseYear: String {
        get {
            return releaseDate.count > 0 ? String(releaseDate.split(separator: "-")[0])
                : ""
        }
    }
    
    func getCellInfo() -> String {
        return title
    }
}
