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
    
    private lazy var filmView: FilmView = {
        let view = FilmView()
        view.delegate = self
        return view
    }()

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
        viewModel.fetchMovie()
        
        setupBindings()
        setupInteractions()
    }
    
    private func setupBindings(){
        viewModel.props.subscribe(onNext: { [weak self] props in
            guard let self, let props else { return }
            self.filmView.setup(with: props)
        }).disposed(by: self.disposeBag)
    }
    
    private func setupInteractions() {
        filmView.backButton.rx.tap.asDriver().drive(onNext: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        /*
        filmView.crawlingButton.rx.tap
            .asDriver()
            .drive(onNext: {
                do {
                    let film = try self.viewModel.props.value()
                    let viewModel = OpeningCrawlingViewModel(film.openingCrawl.replacingOccurrences(of: "\r\n", with: "\n", options: .regularExpression, range: nil))
                    let controller = OpeningCrawlingViewController(viewModel: viewModel)
                    
                    self.navigationController?.showDetailViewController(controller,sender: nil)
                } catch(let error){
                    debugPrint(error)
                }
            }).disposed(by: disposeBag)
        
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
        
        let controller = ViewControllerFactory.shared.makeListViewController(for: urls, with: "Characters")
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapSpeciesButton() {
        
    }
    
    func didTapVehiclesButton() {
        
    }
    
    func didTapPlanetsButton() {
        
    }
    
    
}
