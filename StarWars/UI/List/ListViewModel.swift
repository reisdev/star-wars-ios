//
//  ListViewModel.swift
//  StarWars
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    private let service: StarWarsServiceProtocol
    
    public let urls = BehaviorRelay<[URL]>(value: [])
    public let title = BehaviorRelay<String>(value: "List")
    
    init(service: StarWarsServiceProtocol, items: [URL], title: String){
        self.service = service
        self.title.accept(title)
        self.urls.accept(items)
    }
    
    func getItemByIndex(index: Int) -> URL {
        urls.value[index]
    }
    
    func search(text: String) {
        Task {
            do {
                let response: Response<Result> = try await service.search(.films, search: title.value.lowercased())
                
                urls.accept(response.results.map { $0.url })
            } catch(let error) {
                print(error)
            }
        }
    }
}
