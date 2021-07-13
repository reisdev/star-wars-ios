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
    
    var customView: FilmView {
        return view as! FilmView
    }
    
    public var filmURL: String = "";
    let disposeBag = DisposeBag()
    var viewModel: FilmViewModel = FilmViewModel("");
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        self.view = FilmView()
        self.viewModel = FilmViewModel("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupInteractions()
    }
    
    private func setupBindings(){
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: customView.charactersButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: customView.charactersButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: customView.speciesButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: customView.speciesButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: customView.planetsButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: customView.planetsButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: customView.vehiclesButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: customView.vehiclesButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: customView.crawlingButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .bind(to: customView.crawlingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.film.subscribe(onNext: { film in
            self.customView.movieTitle.text = film.title
            self.customView.movieYear.text = film.releaseYear
            
            self.customView.directorName.text = film.director
            self.customView.producerName.text = film.producer
        }).disposed(by: self.disposeBag)
    }
    
    private func setupInteractions(){
        customView.crawlingButton.rx.tap.asDriver().drive(onNext: {
            do {
                let film = try self.viewModel.film.value()
                let viewModel = OpeningCrawlingViewModel(film.openingCrawl.replacingOccurrences(of: "\r\n", with: "\n", options: .regularExpression, range: nil))
                let controller = OpeningCrawlingViewController(viewModel: viewModel)
                
                self.navigationController?.showDetailViewController(controller,sender: nil)
            } catch(let error){
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
        
        customView.charactersButton.rx.tap.asDriver().drive(onNext: {
            do {
                let controller = ListViewController<People>()
                controller.viewModel.urls.onNext(try self.viewModel.film.value().characters)
                controller.viewModel.title.onNext("Characters")
                
                self.navigationController?.pushViewController(controller, animated: true)
            } catch(let error) {
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
        
        customView.speciesButton.rx.tap.asDriver().drive(onNext: {
            do {
                let controller = ListViewController<Specie>()
                
                controller.viewModel.urls.onNext(try self.viewModel.film.value().species)
                controller.viewModel.title.onNext("Species")
                
                self.navigationController?.pushViewController(controller, animated: true)
            } catch(let error) {
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
        
        customView.planetsButton.rx.tap.asDriver().drive(onNext: {
            do {
                let controller = ListViewController<Planet>()
                
                controller.viewModel.urls.onNext(try self.viewModel.film.value().planets)
                controller.viewModel.title.onNext("Planets")
                
                self.navigationController?.pushViewController(controller, animated: true)
            } catch(let error) {
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
        
        customView.vehiclesButton.rx.tap.asDriver().drive(onNext: {
            do {
                let controller = ListViewController<Vehicle>()
                
                controller.viewModel.urls.onNext(try self.viewModel.film.value().vehicles)
                controller.viewModel.title.onNext("Vehicles")
                
                self.navigationController?.pushViewController(controller, animated: true)
            } catch(let error) {
                debugPrint(error)
            }
        }).disposed(by: disposeBag)
    }
}

