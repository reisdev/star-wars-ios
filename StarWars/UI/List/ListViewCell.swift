//
//  ListViewCell.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 31/01/22.
//

import Foundation
import UIKit

class ListViewCell: UITableViewCell {
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: .chevronRight)
        imageView.backgroundColor = .darkGray
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBaseStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            setupSelectedStyle()
        } else {
            setupDefaultStyle()
        }
    }
}

extension ListViewCell {
    
    private func setupBaseStyle() {
        textLabel?.textColor = .systemYellow
        backgroundColor = .darkGray
        selectionStyle = .none

        accessoryView = chevronImageView
        accessoryView?.frame.origin.x += 20.0
    }
    
    private func setupSelectedStyle() {
        backgroundColor = .systemYellow
        
        chevronImageView.backgroundColor = .systemYellow
        chevronImageView.tintColor = .black
        
        textLabel?.textColor = .black
    }
    
    private func setupDefaultStyle() {
        backgroundColor = .darkGray
        
        chevronImageView.backgroundColor = .darkGray
        chevronImageView.tintColor = .systemYellow
        
        textLabel?.textColor = .systemYellow
    }
}
