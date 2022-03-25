//
//  StarshipModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct Starship: Model {
    var name: String
    var url: String
    
    func getCellInfo() -> String {
        return name
    }
}
