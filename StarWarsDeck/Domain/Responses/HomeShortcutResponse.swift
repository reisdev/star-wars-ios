//
//  HomeShortcutResponse.swift
//  StarWarsDeck
//
//  Created by Matheus dos Reis de Jesus on 03/08/23.
//

import Foundation

struct HomeShortcutResponse: Decodable {
    let shortcuts: [HomeShortcut]
}
