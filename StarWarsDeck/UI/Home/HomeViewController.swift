//
//  HomeViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 25/04/21.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    private unowned var customView: HomeView {
        return view as! HomeView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lyfecycle
    override func loadView() {
        self.view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindObservables()
    }
    
    // MARK: Bindings
    private func bindObservables() {
        viewModel.shortcuts.bind(to: customView.shortcutsCollectionView.rx.items) { (collectionView, index, data) in
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell: HomeShortcutViewCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: HomeShortcutViewCell.self),
                    for: indexPath
            ) as? HomeShortcutViewCell
            else {
                let cell = HomeShortcutViewCell()
                cell.setup(with: data)
                return cell
            }
            cell.setup(with: data)
            return cell
        }.disposed(by: disposeBag)
        
        customView.shortcutsCollectionView.rx.itemSelected
            .asControlEvent()
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let self = self else { return }
                let cell = self.customView.shortcutsCollectionView.cellForItem(at: indexPath) as? HomeShortcutViewCell
                let item = self.viewModel.getItemByIndexPath(indexPath: indexPath)
                
                cell?.isUserInteractionEnabled = false
                cell?.setLoading(with: true)
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
                    cell?.setLoading(with: false)
                }, onError: { error in
                    cell?.isUserInteractionEnabled = true
                    cell?.setLoading(with: false)
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
    }
}
