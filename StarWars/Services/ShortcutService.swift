//
//  ShortcutService.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 03/08/23.
//

import Foundation

protocol JSONServiceProtocol {
    func fetch<T: Decodable>() throws -> T
}

final class JSONService: JSONServiceProtocol {
    private lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func fetch<T: Decodable>() throws -> T {
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json")!
        
        let data = try Data(contentsOf: fileURL)
        let response = try decoder.decode(T.self, from: data)
        
        return response
    }
}
