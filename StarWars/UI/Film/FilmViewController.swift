//
//  FilmViewController.swift
//  StarWars
//
//  Created by ReisDev on 24/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class FilmViewController: UIViewController {
    
    private lazy var filmView: FilmView = .make {
        $0.delegate = self
    }

    private let disposeBag = DisposeBag()
    private let viewModel: FilmViewModelProtocol
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: FilmViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = filmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupInteractions()

        viewModel.fetch()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20.0, weight: .bold),
            .foregroundColor: UIColor.systemYellow
        ]
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupBindings(){
        viewModel.isFilmSet
            .bind(
                to: filmView.charactersButton.rx.isEnabled,
                filmView.speciesButton.rx.isEnabled,
                filmView.planetsButton.rx.isEnabled,
                filmView.vehiclesButton.rx.isEnabled,
                filmView.crawlingButton.rx.isEnabled
            )
            .disposed(by: disposeBag)

        viewModel.isFilmSet
            .map { $0 ? CGFloat(1) : CGFloat(0.5) }
            .bind(
                to: filmView.speciesButton.rx.alpha,
                filmView.planetsButton.rx.alpha,
                filmView.vehiclesButton.rx.alpha,
                filmView.crawlingButton.rx.alpha,
                filmView.charactersButton.rx.alpha
            )
            .disposed(by: disposeBag)

        viewModel.props.subscribe { [weak self] props in
            guard let self, let props else {
                return
            }
            self.filmView.setup(with: props)
        }.disposed(by: self.disposeBag)
    }
    
    private func setupInteractions() {
        filmView.backButton.rx.tap.asDriver().drive { _ in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        

        filmView.crawlingButton.rx.tap
            .asDriver()
            .drive(onNext: {
                guard let film = self.viewModel.props.value else {
                    return
                }

                let viewModel = OpeningCrawlingViewModel(film.openingCrawl.replacingOccurrences(of: "\r\n", with: "\n", options: .regularExpression, range: nil))
                let controller = OpeningCrawlingViewController(viewModel: viewModel)

                self.navigationController?.showDetailViewController(controller,sender: nil)
            }).disposed(by: disposeBag)
        /*
        filmView.speciesButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let controller = ListViewController<Specie>()
                    
                    controller.viewModel.urls.accept(try self.viewModel.props.value().species)
                    controller.viewModel.title.accept("Species")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                } catch(let error) {
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
        
        filmView.planetsButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let controller = ListViewController<Planet>()
                    
                    controller.viewModel.urls.accept(try self.viewModel.props.value().planets)
                    controller.viewModel.title.accept("Planets")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                } catch(let error) {
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
        
        filmView.vehiclesButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let controller = ListViewController<Vehicle>()
                    
                    controller.viewModel.urls.accept(try self.viewModel.props.value().vehicles)
                    controller.viewModel.title.accept("Vehicles")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                } catch(let error) {
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
         */
    }
}

extension FilmViewController: FilmViewDelegate {
    func didTapCharactersButton() {
        guard let urls = viewModel.props.value?.characters else {
            return
        }
        
        let controller: ListViewController<People> = ViewControllerFactory.shared.makeListViewController(
            for: urls,
            with: "Characters"
        )

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapSpeciesButton() {
        
    }
    
    func didTapVehiclesButton() {
        
    }
    
    func didTapPlanetsButton() {
        
    }
    
    
}
