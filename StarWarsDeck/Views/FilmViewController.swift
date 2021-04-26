//
//  FilmViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import UIKit
import RxSwift

class FilmViewController: UIViewController {
    
    public var filmURL: String = "";
    var disposeBag = DisposeBag()
    var film: BehaviorSubject<Film> = BehaviorSubject(value: Film());
    var viewModel: FilmViewModel?;
    
    @IBOutlet var crawlingButton: UIButton!;
    @IBOutlet var movieTitle: UILabel!;
    @IBOutlet var year: UILabel!;
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        
        self.viewModel = FilmViewModel(view: self)
        
        self.film.subscribe(onNext: { film in
            DispatchQueue.main.async {
                self.movieTitle.text = film.title
                self.year.text = film.releaseYear
                self.movieTitle.sizeToFit()
                self.year.sizeToFit()
                self.crawlingButton.isUserInteractionEnabled = true
            }
        }).disposed(by: self.disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel?.loadFilm()
        self.crawlingButton.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is OpeningCrawlingViewController {
            if let vc = (segue.destination as? OpeningCrawlingViewController) {
                do {
                    let film = try self.film.value()
                    vc.crawlingText = film.openingCrawl
                } catch(let error){
                    debugPrint(error)
                }
            }
        }
        
    }
    
}
