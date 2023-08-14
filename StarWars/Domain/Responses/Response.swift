//
//  Response.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 24/12/21.
//

import Foundation

struct Response<T: Codable>: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [T]
}
