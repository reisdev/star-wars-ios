//
//  FilmViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class FilmViewController: UIViewController {
    
    public var filmURL: String = "";
    var disposeBag = DisposeBag()
    var viewModel: FilmViewModel = FilmViewModel();
    
    // MARK: Outlets
    @IBOutlet var charactersList: UITableView!;
    @IBOutlet var crawlingButton: UIButton!;
    @IBOutlet var charsButton: UIButton!;
    @IBOutlet var speciesButton: UIButton!;
    @IBOutlet var planetsButton: UIButton!;
    @IBOutlet var movieTitle: UILabel!;
    @IBOutlet var director: UILabel!;
    @IBOutlet var producer: UILabel!;
    @IBOutlet var year: UILabel!;
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        
        self.viewModel = FilmViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupInteractions()
        self.viewModel.loadFilm()
    }
    
    private func setupUI(){
        self.crawlingButton!.isEnabled = false
    }
    
    private func setupBindings(){
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: charsButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: charsButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: speciesButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: speciesButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: planetsButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: planetsButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: crawlingButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: crawlingButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.film.subscribe(onNext: { film in
            DispatchQueue.main.async {
                self.movieTitle.text = film.title
                self.year.text = film.releaseYear
                
                self.director.text = film.director
                self.producer.text = film.producer
                
                self.movieTitle.sizeToFit()
                self.director.sizeToFit()
                self.producer.sizeToFit()
                self.year.sizeToFit()
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func setupInteractions(){
        crawlingButton.rx.tap.asDriver().drive(onNext: {
            do {
                let film = try self.viewModel.film.value()
                let viewModel = OpeningCrawlingViewModel(film.openingCrawl.replacingOccurrences(of: "\r\n", with: "\n", options: .regularExpression, range: nil))
                let controller = OpeningCrawlingViewController(viewModel: viewModel)
                self.navigationController?.showDetailViewController(controller,sender: nil)
            } catch(let error){
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
        
        charsButton.rx.tap.asDriver().drive(onNext: {
            do {
                let controller = ListViewController<People>()
                controller.viewModel.urls.onNext(try self.viewModel.film.value().characters)
                controller.viewModel.title.onNext("Characters")

                self.navigationController?.pushViewController(controller, animated: true)
            } catch(let error) {
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
        
        speciesButton.rx.tap.asDriver().drive(onNext: {
            do {
                let controller = ListViewController<Specie>()
                
                controller.viewModel.urls.onNext(try self.viewModel.film.value().species)
                controller.viewModel.title.onNext("Species")

                self.navigationController?.pushViewController(controller, animated: true)
            } catch(let error) {
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
        
        planetsButton.rx.tap.asDriver().drive(onNext: {
            do {
                let controller = ListViewController<Planet>()
                
                controller.viewModel.urls.onNext(try self.viewModel.film.value().planets)
                controller.viewModel.title.onNext("Planets")
                self.navigationController?.pushViewController(controller, animated: true)
            } catch(let error) {
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
    }
}

