//
//  ButtonProps.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 03/08/23.
//

import UIKit

struct ButtonProps {
    enum ButtonStyle {
        case primary
        case secondary
        case icon(UIImage)
    }
    
    var title: String?
    var style: ButtonStyle
    var image: UIImage?
    var cornerRadius: CGFloat?
    var rounded: Bool
    
    init(style: ButtonStyle,
         title: String? = nil,
         image: UIImage? = nil,
         rounded: Bool = false,
         cornerRadius: CGFloat? = 8.0) {
        self.style = style
        self.title = title
        self.image = image
        self.rounded = false
        self.cornerRadius = cornerRadius
    }
}

extension ButtonProps {
    var titleColor: UIColor {
        switch style {
        case .primary:
            return .black
        default:
            return .systemYellow
        }
    }
    
    var backgroundColor: UIColor {
        switch style {
        case .primary:
            return .systemYellow
        default:
            return .clear
        }
    }
    
    var tintColor: UIColor {
        switch style {
        case .primary:
            return .black
        default:
            return .systemYellow
        }
    }
}
