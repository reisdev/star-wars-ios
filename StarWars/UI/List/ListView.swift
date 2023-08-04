//
//  ListView.swift
//  StarWars
//
//  Created by ReisDev on 08/07/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
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
        return tableView
    }()
    
    lazy var searchTextField: UITextField = {
        let field = UITextField(frame: .zero)
        field.textColor = .systemYellow
        field.backgroundColor = .darkGray
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.systemYellow.cgColor
        field.layer.cornerRadius = 8.0
        field.layer.masksToBounds = true
        
        field.leftViewMode = .always
        field.rightViewMode = .always
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: Metrics.searchFieldHeight))
        
        let image = UIImage(systemName: "magnifyingglass")?
            .withTintColor(.systemYellow)
            .withRenderingMode(.alwaysTemplate)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let rightView = UIView(frame: CGRect(
            x: -8.0, y: 0,
            width: (image?.size.width ?? 0) + 8.0,
            height: image?.size.height ?? 0)
        )
        field.rightView = rightView
        rightView.addSubview(imageView)
        
        return field
    }()
    
    // - MARK: Init
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
        addSubview(searchTextField)
        addSubview(itemsTableView)
    }
    
    internal func setupConstraints(){
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(Metrics.contentSpacing)
            make.leading.trailing.equalToSuperview().inset(Metrics.contentMargin)
            make.height.equalTo(Metrics.searchFieldHeight)
        }
        itemsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(Metrics.contentSpacing)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .darkGray
        tintColor = .yellow
    }
}
