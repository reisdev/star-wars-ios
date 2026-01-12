//
//  Response.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 24/12/21.
//

import Foundation

struct Response<T: Codable>: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
}
