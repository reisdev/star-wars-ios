//
//  FilmViewModel.swift
//  StarWarsDeck
//
//  Created by mobile2you on 09/07/21.
//

import Foundation
import RxSwift

class FilmViewModel {
    
    var filmURL:String?
    let film: BehaviorSubject<Film> = BehaviorSubject(value: Film());
    let disposeBag = DisposeBag()
    
    func loadFilm(){
        APIService.shared.get(self.filmURL ?? "").subscribe(onNext: { (film: Film) in
            self.film.onNext(film)
        }, onError : { error in
            debugPrint(error)
        }).disposed(by: self.disposeBag)
    }
    
    var isFilmSet: Observable<Bool> {
        return film.asObservable().map({ $0.title != "" })
    }
}
