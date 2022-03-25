//
//  HomeViewModel.swift
//  StarWarsDeck
//
//  Created by Matheus dos Reis de Jesus on 24/12/21.
//

import Foundation
import UIKit
import RxCocoa

public struct HomeShortcut {
    var title: String
    var url: String
    var icon: UIImage?
}

final class HomeViewModel {
    
    let shortcuts = BehaviorRelay<[HomeShortcut]>(value: [
        HomeShortcut(title: "Films", url: "https://swapi.dev/api/films/", icon: UIImage(systemName: "play.rectangle.fill")),
        HomeShortcut(title: "People", url: "https://swapi.dev/api/people/", icon: UIImage(systemName: "person.fill")),
        HomeShortcut(title: "Planets", url: "https://swapi.dev/api/planets/", icon: UIImage(systemName: "globe")),
        HomeShortcut(title: "Species", url: "https://swapi.dev/api/species/", icon: UIImage(named: "dna")),
        HomeShortcut(title: "Starships", url: "https://swapi.dev/api/starships/", icon: UIImage(systemName: "airplane")),
        HomeShortcut(title: "Vehicles", url: "https://swapi.dev/api/vehicles/", icon: UIImage(systemName: "car.fill"))
    ])
    
    func getItemByIndexPath(indexPath: IndexPath) -> HomeShortcut {
        return shortcuts.value[indexPath.row]
    }
}
