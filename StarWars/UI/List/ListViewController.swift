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
    
    // MARK: CONSTANTS
    private let disposeBag = DisposeBag()
    
    // MARK: PROPERTIES
    private let viewModel: ListViewModel<T>
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
        }.disposed(by:disposeBag)

        listView.itemsTableView.rx
            .modelSelected(Film.self)
            .subscribe { item in
                let viewController = FilmViewController(
                    viewModel: FilmViewModel(film: item)
                )
                self.navigationController?.pushViewController(viewController, animated: true)
            }.disposed(by: disposeBag)
    }
}
