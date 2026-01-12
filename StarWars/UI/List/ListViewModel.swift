//
//  ListViewModel.swift
//  StarWars
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift
import RxCocoa

final class ListViewModel<T: Model> {
    private let service: StarWarsServiceProtocol

    public var urls: [URL] = []
    public let title: String
    public let items = BehaviorRelay<[T]>(value: [])

    init(
        service: StarWarsServiceProtocol = StarWarsService(),
        urls: [URL] = [],
        title: String
    ) {
        self.service = service
        self.title = title
        self.urls = urls
    }

    func fetch() {
        guard urls.isEmpty else {
            return
        }

        Task.detached { [weak self] in
            guard let self, let request = request() else { return }

            do {
                let response: [T] = try await service.get(request)
                items.accept(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func get(for indexPath: IndexPath) -> T {
        items.value[indexPath.row]
    }

    private func request() -> StarWarsRequest? {
        switch T.self {
        case is People.Type: .people
        case is Specie.Type: .species
        case is Vehicle.Type: .vehicles
        case is Planet.Type: .planets
        case is Starship.Type: .starships
        case is Film.Type: .films
        default: .none
        }
    }
}
