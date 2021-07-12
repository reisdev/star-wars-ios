//
//  ListViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 08/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewCell: UITableViewCell {
}

class ListViewController<T: Decodable>: UIViewController {
    
    // MARK: Constants
    private let disposeBag = DisposeBag()
    
    // MARK: Variables
    var viewModel: ListViewModel = ListViewModel([],"");
    
    convenience init(vm: ListViewModel) {
        self.init()
        self.viewModel = vm
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
    
    private func setupUI(){
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .systemYellow
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupBinding(){
        viewModel.urls.bind(to: (self.view as! ListView).itemsTableView.rx.items) { (tableView,index,url) in
            let cell = UITableViewCell(style: .default,reuseIdentifier: "cell")
            cell.textLabel!.textColor = .systemYellow
            cell.contentView.backgroundColor = .black
            APIService.shared.get(url)
                .subscribe(onNext: { (data: T) in
                    cell.textLabel!.text = (data as! Model).getCellInfo()
                }).disposed(by: self.disposeBag)
            return cell
        }.disposed(by:disposeBag)
        
        viewModel.title.subscribe(onNext: { (title) in
            self.navigationItem.title = title
        }).disposed(by: disposeBag)
        
    }
}
