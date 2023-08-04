//
//  HomeViewModel.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 24/12/21.
//

import Foundation
import UIKit
import RxCocoa

public struct HomeShortcut: Decodable {
    var title: String
    var url: String
    var iconName: String
}

extension HomeShortcut {
    var iconImage: UIImage? {
        UIImage(named: iconName) ?? UIImage(systemName: iconName)
    }
}

protocol HomeViewModelProtocol {
    var shortcuts: BehaviorRelay<[HomeShortcut]> { get }
    
    func fetchShortcuts()
    func getItem(by indexPath: IndexPath) -> HomeShortcut
}

final class HomeViewModel: HomeViewModelProtocol {
    
    let shortcuts = BehaviorRelay<[HomeShortcut]>(value: [])
    
    private let service: JSONServiceProtocol
    
    init(service: JSONServiceProtocol) {
        self.service = service
    }
    
    func fetchShortcuts() {
        do {
            let response: HomeShortcutResponse = try service.fetch()
            shortcuts.accept(response.shortcuts)
        } catch(let error) {
            print(error)
        }
    }
    
    func getItem(by indexPath: IndexPath) -> HomeShortcut {
        shortcuts.value[indexPath.row]
    }
}
