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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupInteractions()

        viewModel.fetch()
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
            filmView.setup(with: props)
        }.disposed(by: self.disposeBag)
    }
    
    private func setupInteractions() {
        filmView.backButton.rx.tap.asDriver().drive { [weak self] _ in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)

        filmView.crawlingButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self,
                      let film = self.viewModel.props.value else {
                    return
                }

                let crawlText = film.openingCrawl.replacingOccurrences(of: "\r\n", with: "\n", options: .regularExpression, range: nil)

                let viewModel = OpeningCrawlingViewModel(crawlText)
                let controller = OpeningCrawlingViewController(viewModel: viewModel)

                navigationController?.showDetailViewController(controller,sender: nil)
            }.disposed(by: disposeBag)
    }
}

extension FilmViewController: FilmViewDelegate {
    func didTapCharactersButton() {
        guard let props = viewModel.props.value else {
            return
        }
        
        let controller = ListViewController<People>(
            viewModel: .init(
                urls: props.vehicles,
                title: "\(props.title) - Characters"
            )
        )

        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapSpeciesButton() {
        guard let props = viewModel.props.value else {
            return
        }

        let controller = ListViewController<Specie>(
            viewModel: .init(
                urls: props.planets,
                title: "\(props.title) - Species"
            )
        )

        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapVehiclesButton() {
        guard let props = viewModel.props.value else {
            return
        }

        let controller = ListViewController<Vehicle>(
            viewModel: .init(
                urls: props.vehicles,
                title: "\(props.title) - Vehicles"
            )
        )

        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapPlanetsButton() {
        guard let props = viewModel.props.value else {
            return
        }

        let controller = ListViewController<Planet>(
            viewModel: .init(
                urls: props.planets,
                title: "\(props.title) - Planets"
            )
        )

        navigationController?.pushViewController(controller, animated: true)
    }
}
