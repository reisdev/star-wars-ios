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
    
    func fetchMovie()
}

final class FilmViewModel: FilmViewModelProtocol {
    
    private let service: StarWarsServiceProtocol
    private let id: String
    
    let props = BehaviorRelay<FilmViewProps?>(value: nil)

    init(service: StarWarsServiceProtocol, id: String) {
        self.service = service
        self.id = id
    }
    
    func fetchMovie() {
        Task {
            do {
                let film: Film = try await service.get(.films, id: id)
                
                props.accept(FilmViewProps(from: film))
            } catch(let error) {
                print(error)
            }
        }
    }
}
