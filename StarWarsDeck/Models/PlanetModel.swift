//
//  PlanetModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

class Planet: Model {
    var name: String
    
    func getCellInfo() -> String {
        return name
    }
}
