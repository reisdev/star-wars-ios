//
//  ListView.swift
//  StarWarsDeck
//
//  Created by ReisDev on 08/07/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ListView: UIView {
    
    var itemsTableView = UITableView()
    
    // - MARK: Init
    init(){
        super.init(frame: .zero)
        addViews()
        addConstraints()
        addStyle()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        addStyle()
        addConstraints()
    }
    
    private func addStyle() {
        backgroundColor = .black
        tintColor = .yellow
        itemsTableView.backgroundColor = .black
        itemsTableView.separatorStyle = .none
    }
    
    private func addViews() {
        addSubview(itemsTableView)
    }
    
    private func addConstraints(){
        itemsTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}