//
//  SpecieModel.swift
//  StarWars
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct Specie: Model {
    let name: String
    let url: URL

    func getCellInfo() -> String {
        name
    }
}
