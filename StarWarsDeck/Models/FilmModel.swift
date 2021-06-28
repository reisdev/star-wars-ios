//
//  Film.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import Foundation
import UIKit
import RxSwift

struct Film: Codable {
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
    var url : String;
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
}

extension Film {
    init(){
        title = ""
        episodeId = 0
        openingCrawl = ""
        director = ""
        producer = ""
        releaseDate = ""
        species = []
        starships = []
        vehicles = []
        characters = []
        planets = []
        url = ""
        created = ""
        edited = ""
    }
}

class FilmViewModel {
    
    let view: FilmViewController;
    let disposeBag = DisposeBag()
    
    init(view: UIViewController) {
        self.view = view as! FilmViewController;
    }
    
    func loadFilm(){
        APIService.shared.get(self.view.filmURL).subscribe(onNext: { (film: Film) in
            self.view.film.onNext(film)
        }, onError : { error in
            debugPrint(error)
        }).disposed(by: self.disposeBag)
    }
}
