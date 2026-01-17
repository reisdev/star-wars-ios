//
//  Model.swift
//  StarWars
//
//  Created by ReisDev on 09/07/21.
//

import Foundation

protocol Model: Codable {
    var url: URL { get }
    func getCellInfo() -> String
}
