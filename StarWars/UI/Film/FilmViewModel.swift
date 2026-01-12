//
//  FilmViewModel.swift
//  StarWars
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol FilmViewModelProtocol {
    var props: BehaviorRelay<FilmViewProps?> { get }
    var isFilmSet: BehaviorRelay<Bool> { get }

    func fetch()
}

final class FilmViewModel: FilmViewModelProtocol {
    
    private let service: StarWarsServiceProtocol
    private let id: String?

    let props = BehaviorRelay<FilmViewProps?>(value: nil)
    let isFilmSet = BehaviorRelay(value: false)

    init(
        service: StarWarsServiceProtocol = StarWarsService(),
        id: String
    ) {
        self.service = service
        self.id = id
    }
    
    init(
        service: StarWarsServiceProtocol = StarWarsService(),
        film: Film
    ) {
        self.service = service
        self.id = nil
        self.props.accept(FilmViewProps(from: film))
        self.isFilmSet.accept(true)
    }

    func fetch() {
        guard let id else { return }
        Task {
            do {
                let film: Film = try await service.get(.films, id: id)
                
                props.accept(FilmViewProps(from: film))
                isFilmSet.accept(true)
            } catch(let error) {
                print(error)
            }
        }
    }
}
