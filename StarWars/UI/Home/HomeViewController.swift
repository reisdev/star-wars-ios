//
//  HomeViewController.swift
//  StarWars
//
//  Created by ReisDev on 25/04/21.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private let viewModel: HomeViewModelProtocol
    private let disposeBag = DisposeBag()

    private lazy var homeView: HomeView = .make {
        $0.accessibilityIdentifier = A11yIdentifiers.Home.view
    }

    // MARK: Init

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lyfecycle

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindObservables()

        viewModel.fetchShortcuts()
    }

    // MARK: Bindings

    private func bindObservables() {
        viewModel.shortcuts.bind(
            to: homeView.shortcutsCollectionView.rx.items(
                cellIdentifier: HomeShortcutViewCell.identifier,
                cellType: HomeShortcutViewCell.self
            )
        ) { (collectionView, item, cell) in
            cell.setup(with: item)
        }.disposed(by: disposeBag)

        homeView.shortcutsCollectionView.rx
            .itemSelected
            .asControlEvent()
            .subscribe { [weak self] (index) in
                guard let self else { return }
                let item = viewModel.getItem(by: IndexPath(row: index.row, section: 0))

                let viewController = switch item.title {
                case "Films":
                    ListViewController<Film>(viewModel: ListViewModel(title: item.title))
                case "People":
                    ListViewController<People>(viewModel: ListViewModel(title: item.title))
                case "Planets":
                    ListViewController<Planet>(viewModel: ListViewModel(title: item.title))
                case "Species":
                    ListViewController<Specie>(viewModel: ListViewModel(title: item.title))
                case "Vehicles":
                    ListViewController<Vehicle>(viewModel: ListViewModel(title: item.title))
                case "Starships":
                    ListViewController<Starship>(viewModel: ListViewModel(title: item.title))
                default:
                    UIViewController()
                }

                navigationController?.pushViewController(viewController, animated: true)
            }.disposed(by: disposeBag)
    }
}
