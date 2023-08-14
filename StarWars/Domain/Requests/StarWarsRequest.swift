//
//  StarWarsRequest.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 10/08/23.
//

import Foundation

enum StarWarsRequest: String {
    case people
    case films
    case vehicles
    case species
    case starships
    case planets
    
    private var baseURL: String { "https://swapi.dev/api" }
    
    var path: String {
        String(format: "%@/%@", baseURL, rawValue)
    }
    
    var url: URLRequest? {
        guard let url = URL(string: path) else { return nil }
        return URLRequest(url: url)
    }
    
    var model: Model.Type {
        switch self {
        case .people:
            return People.self
        case .films:
            return Film.self
        case .vehicles:
            return Vehicle.self
        case .species:
            return Specie.self
        case .starships:
            return Starship.self
        case .planets:
            return Planet.self
        }
    }
    
    func find(_ id: String) -> URLRequest? {
        guard let url = URL(string: String(format: "%@/%@", path, id)) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    func search(_ text: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: path) else { return nil }
        urlComponents.queryItems = [.init(name: "search", value: text)]
        
        guard let url = urlComponents.url else { return nil }
        
        return URLRequest(url: url)
    }
}
