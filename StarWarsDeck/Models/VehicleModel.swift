//
//  VehicleModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import Foundation

struct Vehicle: Model {
    var name: String
    
    func getCellInfo() -> String {
        return name
    }
}
