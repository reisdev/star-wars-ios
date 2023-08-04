//
//  Model.swift
//  StarWars
//
//  Created by ReisDev on 09/07/21.
//

import Foundation

protocol Model: Codable {
    func getCellInfo() -> String
}
