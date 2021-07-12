//
//  FilmViewModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift

class FilmViewModel {
    
    var filmURL: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    let film: BehaviorSubject<Film> = BehaviorSubject(value: Film());
    let disposeBag = DisposeBag()
    
    init(_ url: String) {
        self.filmURL.onNext(url)
        
        filmURL.subscribe(onNext: { url in
            if(url.count == 0) {
                return
            }
            APIService.shared.get(url).subscribe(onNext: { (film: Film) in
                self.film.onNext(film)
            }, onError : { error in
                debugPrint(error)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }

    
    var isFilmSet: Observable<Bool> {
        return film.asObservable().map({ $0.title != "" })
    }
}
