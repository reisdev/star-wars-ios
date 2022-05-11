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
        setupNavigationBar()
        setupBindings()
        setupInteractions()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 20.0, weight: .bold), .foregroundColor: UIColor.systemYellow]
        self.navigationController?.navigationBar.isTranslucent = true
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
            self.title = film.title

            self.customView.movieYear.text = film.releaseYear
            self.customView.directorName.text = film.director
            self.customView.producerName.text = film.producer
            
            self.customView.movieCoverImageView.image = .init(named: "episode\(film.episodeId)")
        }).disposed(by: self.disposeBag)
    }
    
    private func setupInteractions(){
        customView.crawlingButton.rx.tap
            .asDriver()
            .drive(onNext: {
                let film = self.viewModel.film.value
                let viewModel = OpeningCrawlingViewModel(film.openingCrawl.replacingOccurrences(of: "\r\n", with: "\n", options: .regularExpression, range: nil))
                let controller = OpeningCrawlingViewController(viewModel: viewModel)
                
                self.navigationController?.showDetailViewController(controller,sender: nil)
            }).disposed(by: disposeBag)
        
        customView.charactersButton.rx.tap
            .asDriver()
            .drive(onNext: {
                let controller = ListViewController<People>()
                controller.viewModel.urls.accept(self.viewModel.film.value.characters)
                controller.viewModel.title.accept("Characters")
                
                self.navigationController?.pushViewController(controller, animated: true)
            }).disposed(by: disposeBag)
        
        customView.speciesButton.rx.tap
            .asDriver()
            .drive(onNext: {
                let controller = ListViewController<Specie>()
                controller.viewModel.urls.accept(self.viewModel.film.value.species)
                controller.viewModel.title.accept("Species")
                
                self.navigationController?.pushViewController(controller, animated: true)
            }).disposed(by: disposeBag)
        
        customView.planetsButton.rx.tap
            .asDriver()
            .drive(onNext: {
                let controller = ListViewController<Planet>()
                controller.viewModel.urls.accept(self.viewModel.film.value.planets)
                controller.viewModel.title.accept("Planets")
                
                self.navigationController?.pushViewController(controller, animated: true)
            }).disposed(by: disposeBag)
        
        customView.vehiclesButton.rx.tap
            .asDriver()
            .drive(onNext: {
                let controller = ListViewController<Vehicle>()
                controller.viewModel.urls.accept(self.viewModel.film.value.vehicles)
                controller.viewModel.title.accept("Vehicles")
                
                self.navigationController?.pushViewController(controller, animated: true)
            }).disposed(by: disposeBag)
    }
}

