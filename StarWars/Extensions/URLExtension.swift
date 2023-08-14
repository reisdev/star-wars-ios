//
//  StringExtension.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 10/08/23.
//

import Foundation

extension URL {
    var getModelFromUrl: String? { pathComponents[pathComponents.endIndex - 2] }
    var getIdFromUrl: String? { pathComponents[pathComponents.endIndex - 1] }
}
