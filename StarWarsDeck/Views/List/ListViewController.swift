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
        
        accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
        
        contentView.tintColor = .systemYellow
        textLabel!.textColor = .systemYellow
        backgroundColor = .black

        accessoryView?.backgroundColor = .black
        accessoryView?.tintColor = .systemYellow
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = .systemYellow
            
            accessoryView?.backgroundColor = .systemYellow
            accessoryView?.superview?.backgroundColor = .systemYellow
            accessoryView?.tintColor = .black
            
            textLabel?.textColor = .black
        } else {
            contentView.backgroundColor = .black
            
            accessoryView?.backgroundColor = .black
            accessoryView?.tintColor = .systemYellow
            accessoryView?.superview?.backgroundColor = .black
            
            textLabel?.textColor = .systemYellow
        }
    }
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
            let cell = ListViewCell(style: .default,reuseIdentifier: "cell")
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
