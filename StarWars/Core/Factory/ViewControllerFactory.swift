//
//  ViewControllerFactory.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 27/07/23.
//

import Foundation

protocol ViewControllerFactoryProtocol {
    func makeHomeViewController() -> HomeViewController
    func makeListViewController(for urls: [URL], with title: String) -> ListViewController
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
    
    func makeListViewController(for urls: [URL], with title: String) -> ListViewController {
        let service = StarWarsService()
        let viewModel = ListViewModel(service: service, items: urls, title: title)
        return ListViewController(viewModel: viewModel)
    }
}
