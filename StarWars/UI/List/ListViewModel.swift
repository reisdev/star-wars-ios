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
    public let urls = BehaviorRelay<[String]>(value: [])
    public let title = BehaviorRelay<String>(value: "List")
    private let disposeBag = DisposeBag()
    
    init(_ items: [String],_ title: String){
        urls.accept(items)
    }
    
    func getItemByIndex(index: Int) -> String {
        return urls.value[index]
    }
    
    func search(text: String) {
        APIService.shared.search(resource: title.value.lowercased(), search: text)
            .subscribe { [weak self] (data: Response) in
                guard let self = self else { return }
                self.urls.accept(data.results.map { $0.url })
        }.disposed(by: disposeBag)
    }
}
