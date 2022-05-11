//
//  FilmViewModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift
import RxCocoa

class FilmViewModel {
    
    var filmURL = BehaviorSubject(value: "")
    let film = BehaviorRelay(value: Film());
    let disposeBag = DisposeBag()
    
    init(_ url: String) {
        self.filmURL.onNext(url)
        
        filmURL.subscribe(onNext: { url in
            if url.isEmpty { return }
            APIService.shared.get(url).subscribe(onNext: { (film: Film) in
                self.film.accept(film)
            }, onError : { error in
                debugPrint(error)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    init(_ film: Film) {
        self.film.accept(film)
    }
    
    var isFilmSet: Observable<Bool> {
        return film.asObservable().map({ $0.title != "" })
    }
}
