//
//  ListViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 08/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    private unowned var customView: ListView {
        return self.view as! ListView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: CONSTANTS
    private let disposeBag = DisposeBag()
    
    // MARK: PROPERTIES
    var viewModel: ListViewModel = ListViewModel([],"");
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: View Lifecycle
    convenience init(viewModel: ListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        self.view = ListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Setups
    private func setupUI(){
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(named: "magnifyingglass"), style: .plain, target: self, action: #selector(setupSearchBar))
    }
    
    @objc private func setupSearchBar() {
        navigationController?.navigationBar.showSearchField()
    }
    
    private func setupBinding(){
        viewModel.urls.bind(to: customView.itemsTableView.rx.items) { (tableView,index,url) in
            let cell = ListViewCell(style: .default, reuseIdentifier: "cell")
            APIService.shared.get(url)
                .subscribe(onNext: { (data: Model) in
                    cell.textLabel?.text = data.getCellInfo()
                }).disposed(by: self.disposeBag)
            return cell
        }.disposed(by:disposeBag)
        
        customView.searchTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe(onDisposed:  { [weak self] in
                guard let self = self else { return }
                guard let text = self.customView.searchTextField.text else { return }
                self.viewModel.search(text: text)
            }).disposed(by: disposeBag)

        /*
        customView.itemsTableView.rx.itemSelected
            .asControlEvent()
            .subscribe(onNext: { indexPath in
                let item = self.viewModel.getItemByIndex(index: indexPath.row)
                
                let type = item.split(separator: "/")[-2]
                switch(type) {
                    case "films":
                        let controller = FilmViewController()
                    case "people":
                    
                    case "planet":
                    
                    case "species":
                        
                    case "vehicles":
                    case "starships":
                
                }
            }).disposed(by: disposeBag)
        */
        
        viewModel.title.subscribe(onNext: { (title) in
            self.navigationItem.title = title
        }).disposed(by: disposeBag)
        
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
