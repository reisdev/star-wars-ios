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
    
    let button = UIButton(type: .custom)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel!.textColor = .systemYellow
        backgroundColor = .black
        
        selectionStyle = .none
        accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))

        accessoryView?.backgroundColor = .black
        accessoryView?.tintColor = .systemYellow
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            backgroundColor = .systemYellow
            
            accessoryView?.backgroundColor = .systemYellow
            accessoryView?.superview?.backgroundColor = .systemYellow
            accessoryView?.tintColor = .black
            
            textLabel?.textColor = .black
        } else {
            backgroundColor = .black
            
            accessoryView?.backgroundColor = .black
            accessoryView?.tintColor = .systemYellow
            accessoryView?.superview?.backgroundColor = .black
            
            textLabel?.textColor = .systemYellow
        }
    }
}

class ListViewController<T: Decodable>: UIViewController {
    
    private unowned var customView: ListView {
        return self.view as! ListView
    }
    
    // MARK: Constants
    private let disposeBag = DisposeBag()
    
    // MARK: Variables
    var viewModel: ListViewModel = ListViewModel([],"");
    
    // MARK: Life cycle
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
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .systemYellow
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupBinding(){
        viewModel.urls.bind(to: customView.itemsTableView.rx.items) { (tableView,index,url) in
            let cell = ListViewCell(style: .default,reuseIdentifier: "cell")
            APIService.shared.get(url)
                .subscribe(onNext: { (data: T) in
                    cell.textLabel!.text = (data as! Model).getCellInfo()
                }).disposed(by: self.disposeBag)
            return cell
        }.disposed(by:disposeBag)
        
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
