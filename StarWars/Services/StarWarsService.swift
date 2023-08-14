//
//  APIService.swift
//  StarWars
//
//  Created by ReisDev on 24/04/21.
//

import Foundation
import RxSwift

protocol StarWarsServiceProtocol {
    func get<T: Decodable>(_ request: StarWarsRequest, id: String?) async throws -> T
    func search<T: Decodable>(_ request: StarWarsRequest, search: String) async throws -> T
}

final class StarWarsService: StarWarsServiceProtocol {
    
    private lazy var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get<T: Decodable>(_ request: StarWarsRequest, id: String?) async throws -> T {
        var urlRequest: URLRequest?
        
        if let id {
            urlRequest = request.find(id)
        } else {
            urlRequest = request.url
        }
        
        guard let urlRequest else {
            throw RequestError.badURL
        }
        
        let (data, _) = try await urlSession.data(for: urlRequest)
        
        return try decoder.decode(T.self, from: data)
    }
    
    func search<T: Decodable>(_ request: StarWarsRequest, search: String) async throws -> T {
        
        guard let url = request.search(search) else {
            throw RequestError.badURL
        }
        
        let (data, _) = try await urlSession.data(for: url)
        
        return try decoder.decode(T.self, from: data)
    }
}

extension StarWarsServiceProtocol {
    func  get<T: Decodable>(_ request: StarWarsRequest) async throws -> T {
        return try await get(request, id: nil)
    }
}
