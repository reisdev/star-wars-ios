//
//  ViewControllerFactory.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 27/07/23.
//

import Foundation

final class ViewControllerFactory {
    static func makeHomeViewController() -> HomeViewController {
        let service = JSONService(fileName: "home_shortcuts")
        let homeViewModel = HomeViewModel(service: service)
        return HomeViewController(viewModel: homeViewModel)
    }

    static func makeListViewController<T: Model>(for urls: [URL], with title: String) -> ListViewController<T> {
        let service = StarWarsService()
        let viewModel = ListViewModel<T>(service: service, urls: urls, title: title)
        return ListViewController(viewModel: viewModel)
    }
}
