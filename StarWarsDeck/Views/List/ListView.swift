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
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
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
        backgroundColor = .black
        tintColor = .yellow
        itemsTableView.backgroundColor = .black
        itemsTableView.separatorStyle = .none
    }
}
