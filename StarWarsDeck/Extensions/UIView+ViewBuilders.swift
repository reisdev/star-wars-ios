//
//  ViewBuilders.swift
//  StarWarsDeck
//
//  Created by ReisDev on 12/07/21.
//

import Foundation
import UIKit
import RxCocoa

extension UIView {
    // MARK: StackView
    func makeGenericStackView(axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 16.0, views: [UIView] = []) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.alignment = alignment
        stack.distribution = distribution
        stack.spacing = spacing
        views.forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }
    
    // MARK: Label
    func makeGenericLabel(text: String = "", fontSize: CGFloat = 16.0, weight: UIFont.Weight = .regular, font: UIFont? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .systemYellow
        label.textAlignment = .left
        
        if let customFont = font {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        }
        
        return label
    }
}
