//
//  SpecieModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct Specie: Model {
    var name: String;
    
    func getCellInfo() -> String {
        return name
    }
}
