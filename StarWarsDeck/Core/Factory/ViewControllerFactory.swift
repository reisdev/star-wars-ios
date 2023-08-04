//
//  ViewControllerFactory.swift
//  StarWarsDeck
//
//  Created by Matheus dos Reis de Jesus on 27/07/23.
//

import Foundation

protocol ViewControllerFactoryProtocol {
    func makeHomeViewController() -> HomeViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    static var shared = {
       return ViewControllerFactory()
    }()
    
    func makeHomeViewController() -> HomeViewController {
        let service = JSONService(fileName: "home_shortcuts")
        let homeViewModel = HomeViewModel(service: service)
        return HomeViewController(viewModel: homeViewModel)
    }
}
