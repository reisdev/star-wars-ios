//
//  ListView.swift
//  StarWars
//
//  Created by ReisDev on 08/07/21.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class ListView: UIView {
    
    // MARK: Constants

    private struct Metrics {
        static let searchFieldHeight: CGFloat = 32
        static let contentMargin: CGFloat = 16
        static let contentSpacing: CGFloat = 8
    }
    
    lazy var itemsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .darkGray
        tableView.separatorStyle = .none
        tableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.identifier)
        return tableView
    }()
    
    // MARK: Init
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


// MARK: ViewCode
extension ListView: ViewCode {
    internal func buildViewHierarchy() {
        addSubview(itemsTableView)
    }
    
    internal func setupConstraints(){
        itemsTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .darkGray
        tintColor = .yellow
    }
}
