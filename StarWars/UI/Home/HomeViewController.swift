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
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let disposeBag = DisposeBag()
    let viewModel: HomeViewModelProtocol
    
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
        viewModel.shortcuts.bind(to: homeView.shortcutsCollectionView.rx.items) { (collectionView, index, data) in
            let indexPath = IndexPath(row: index, section: 0)
            let cell: HomeShortcutViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeShortcutViewCell.self), for: indexPath)
            
            cell.setup(with: data)
            return cell
        }.disposed(by: disposeBag)
        
        homeView.shortcutsCollectionView.rx.itemSelected
            .asControlEvent()
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let self = self else { return }
                let cell = self.homeView.shortcutsCollectionView.cellForItem(at: indexPath)
                let item = self.viewModel.getItem(by: indexPath)
                
                cell?.isUserInteractionEnabled = false
                APIService.shared.get(item.url).subscribe(onNext: { (response: Response) in
                    let urls = response.results.map { $0.url }
                    let title = item.title
                    
                    switch item.title {
                    case "Films":
                        let controller = ListViewController<Film>()
                        controller.viewModel.urls.accept(urls)
                        controller.viewModel.title.accept(title)
                        self.navigationController?.pushViewController(controller, animated: true)
                    case "People":
                        let controller = ListViewController<People>()
                        controller.viewModel.urls.accept(urls)
                        controller.viewModel.title.accept(title)
                        self.navigationController?.pushViewController(controller, animated: true)
                    case "Planets":
                        let controller = ListViewController<Planet>()
                        controller.viewModel.urls.accept(urls)
                        controller.viewModel.title.accept(title)
                        self.navigationController?.pushViewController(controller, animated: true)
                    case "Species":
                        let controller = ListViewController<Specie>()
                        controller.viewModel.urls.accept(urls)
                        controller.viewModel.title.accept(title)
                        self.navigationController?.pushViewController(controller, animated: true)
                    case "Vehicles":
                        let controller = ListViewController<Vehicle>()
                        controller.viewModel.urls.accept(urls)
                        controller.viewModel.title.accept(title)
                        self.navigationController?.pushViewController(controller, animated: true)
                    case "Starships":
                        let controller = ListViewController<Starship>()
                        controller.viewModel.urls.accept(urls)
                        controller.viewModel.title.accept(title)
                        self.navigationController?.pushViewController(controller, animated: true)
                    default:
                        return
                    }
                    cell?.isUserInteractionEnabled = true
                }, onError: { error in
                    cell?.isUserInteractionEnabled = true
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
    }
}
