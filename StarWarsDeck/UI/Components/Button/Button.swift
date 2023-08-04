//
//  Button.swift
//  StarWarsDeck
//
//  Created by Matheus dos Reis de Jesus on 03/08/23.
//

import UIKit

class Button: UIButton {
    init() {
        super.init(frame: .zero)
    }
    
    init(props: ButtonProps) {
        super.init(frame: .zero)
        setup(with: props)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with props: ButtonProps) {
        
        if let title = props.title {
            setTitle(title, for: .normal)
        }
        
        setTitleColor(props.titleColor, for: .normal)
        backgroundColor = props.backgroundColor
        tintColor = props.tintColor
        
        if let image = props.image {
            setImage(image, for: .normal)
            titleEdgeInsets.left = 12.0
        }
        
        if case .icon(let image) = props.style {
            setImage(image, for: .normal)
            widthAnchor.constraint(equalToConstant: 24.0).isActive = true
            heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        } else {
            heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        }
        
        if let cornerRadius = props.cornerRadius {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
}
