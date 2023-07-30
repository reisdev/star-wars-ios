//
//  FilmViewModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift

protocol FilmViewModelProtocol {
    var props: PublishSubject<FilmViewProps> { get }
    
    func fetchMovie()
}

final class FilmViewModel: FilmViewModelProtocol {
    
    let disposeBag = DisposeBag()
    
    let props = PublishSubject<FilmViewProps>()
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func fetchMovie() {
        APIService.shared.get(url)
            .map { FilmViewProps(from: $0) }
            .bind(to: props)
            .disposed(by: self.disposeBag)
    }
}
