//
//  ListViewController.swift
//  StarWars
//
//  Created by ReisDev on 08/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController<T: Model>: UIViewController {

    private lazy var listView = ListView()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Properties
    private let viewModel: ListViewModel<T>
    private let disposeBag = DisposeBag()
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: View Lifecycle
    init(viewModel: ListViewModel<T>) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()

        viewModel.fetch()
    }
    
    // MARK: Setups
    private func setupUI(){
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.title = viewModel.title
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupBinding(){
        viewModel.items
            .bind(
                to: listView.itemsTableView.rx.items(
                    cellIdentifier: ListViewCell.identifier,
                    cellType: ListViewCell.self
                )
            ) { (tableView, item, cell) in
            cell.textLabel?.text = item.getCellInfo()
        }.disposed(by: disposeBag)

        listView.itemsTableView.rx
            .modelSelected(T.self)
            .asControlEvent()
            .subscribe { [weak self] index in
                guard let self, let item = index.element else {
                    return
                }

                let viewController = switch item {
                case let film as Film:
                    FilmViewController(
                        viewModel: FilmViewModel(film: film)
                    )
                case let people as People:
                    PeopleViewController()
                case let planet as Planet:
                    PlanetViewController()
                case let specie as Specie:
                    SpecieViewController()
                default:
                    UIViewController()
                }

                navigationController?.pushViewController(viewController, animated: true)
            }.disposed(by: disposeBag)
    }
}
