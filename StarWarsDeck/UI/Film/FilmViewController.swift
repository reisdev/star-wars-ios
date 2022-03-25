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
    
    private unowned var customView: FilmView {
        return view as! FilmView
    }

    private let disposeBag = DisposeBag()
    var viewModel: FilmViewModel = FilmViewModel("");
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    convenience init(viewModel: FilmViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        self.view = FilmView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupInteractions()
    }
    
    private func setupBindings(){
        
        viewModel.isFilmSet
            .bind(to: customView.charactersButton.rx.isEnabled, customView.speciesButton.rx.isEnabled, customView.planetsButton.rx.isEnabled, customView.vehiclesButton.rx.isEnabled, customView.crawlingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isFilmSet
            .map({ $0 ? CGFloat(1) : CGFloat(0.5) })
            .bind(to: customView.speciesButton.rx.alpha, customView.planetsButton.rx.alpha, customView.vehiclesButton.rx.alpha, customView.crawlingButton.rx.alpha, customView.charactersButton.rx.alpha)
            .disposed(by: disposeBag)
        
        viewModel.film.subscribe(onNext: { film in
            self.customView.movieTitle.text = film.title
            self.customView.movieYear.text = film.releaseYear
            
            self.customView.directorName.text = film.director
            self.customView.producerName.text = film.producer
        }).disposed(by: self.disposeBag)
    }
    
    private func setupInteractions(){
        customView.backButton.rx.tap.asDriver().drive(onNext: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        customView.crawlingButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let film = try self.viewModel.film.value()
                    let viewModel = OpeningCrawlingViewModel(film.openingCrawl.replacingOccurrences(of: "\r\n", with: "\n", options: .regularExpression, range: nil))
                    let controller = OpeningCrawlingViewController(viewModel: viewModel)
                    
                    self.navigationController?.showDetailViewController(controller,sender: nil)
                } catch(let error){
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
        
        customView.charactersButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let controller = ListViewController<People>()
                    controller.viewModel.urls.accept(try self.viewModel.film.value().characters)
                    controller.viewModel.title.accept("Characters")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                } catch(let error) {
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
        
        customView.speciesButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let controller = ListViewController<Specie>()
                    
                    controller.viewModel.urls.accept(try self.viewModel.film.value().species)
                    controller.viewModel.title.accept("Species")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                } catch(let error) {
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
        
        customView.planetsButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let controller = ListViewController<Planet>()
                    
                    controller.viewModel.urls.accept(try self.viewModel.film.value().planets)
                    controller.viewModel.title.accept("Planets")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                } catch(let error) {
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
        
        customView.vehiclesButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let controller = ListViewController<Vehicle>()
                    
                    controller.viewModel.urls.accept(try self.viewModel.film.value().vehicles)
                    controller.viewModel.title.accept("Vehicles")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                } catch(let error) {
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
    }
}

