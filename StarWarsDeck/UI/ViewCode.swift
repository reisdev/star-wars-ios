//
//  ViewCode.swift
//  StarWarsDeck
//
//  Created by mobile2you on 26/09/21.
//

import Foundation
import UIKit

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setup() {
        buildViewHierarchy()
        setupConstraints()
        setupStyle()
    }
    func setupStyle() {
        
    }
}
