//
//  ViewBuilders.swift
//  StarWarsDeck
//
//  Created by ReisDev on 12/07/21.
//

import Foundation
import UIKit
import RxCocoa

// MARK: StackView
func makeGenericStackView(axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 15.0) -> UIStackView{
    let stack = UIStackView()
    stack.axis = axis
    stack.alignment = alignment
    stack.distribution = distribution
    stack.spacing = spacing
    return stack
}

// MARK: Label
func makeGenericLabel(text: String = "",fontSize: CGFloat = 16.0, weight: UIFont.Weight = .regular, font: UIFont? = nil) -> UILabel {
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

// MARK: Button
extension UIButton {
    enum ButtonStyle {
        case primary
        case secondary
    }
}

func makeGenericButton(title: String = "",fontSize: CGFloat = 16.0, image: UIImage? = nil, style: UIButton.ButtonStyle = .primary, rounded: Bool = false) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    
    if let imageView = image {
        button.setImage(imageView, for: .normal)
        button.titleEdgeInsets.left = 10.0
    }
    
    if rounded {
        button.layer.cornerRadius = 4
    }
    
    switch style {
        case .primary:
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .systemYellow
            button.tintColor = .black
            break
        case .secondary:
            button.setTitleColor(.systemYellow, for: .normal)
            button.tintColor = .systemYellow
    }
    
    button.snp.makeConstraints { make in
        if (image != nil && title == "") {
            make.width.equalTo(20.0)
            make.height.equalTo(20.0)
        }
        else {
            make.height.equalTo(40.0)
        }
    }
    
    return button
}
