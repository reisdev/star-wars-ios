//
//  ViewBuilders.swift
//  StarWarsDeck
//
//  Created by ReisDev on 12/07/21.
//

import Foundation
import UIKit
import RxCocoa

extension UIButton {
    enum ButtonStyle {
        case primary
        case secondary
    }
}

extension UIView {
    // MARK: StackView
    func makeGenericStackView(axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 15.0, views: [UIView] = []) -> UIStackView {
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
    func makeGenericButton(title: String = "",fontSize: CGFloat = 16.0, image: UIImage? = nil, style: UIButton.ButtonStyle = .primary, rounded: Bool = false, cornerRadius: CGFloat = 5.0) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        
        if let imageView = image {
            button.setImage(imageView, for: .normal)
            button.titleEdgeInsets.left = 10.0
        }
        
        if rounded {
            button.layer.cornerRadius = cornerRadius
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
}
